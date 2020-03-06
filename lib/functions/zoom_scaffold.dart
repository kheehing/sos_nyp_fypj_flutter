import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sosnyp/functions/circular_image.dart';
import 'package:sosnyp/functions/rootPage.dart';
import 'package:sosnyp/main.dart';
import 'package:sosnyp/pages/about.dart';
import 'package:sosnyp/pages/dashboard.dart';
import 'package:sosnyp/pages/home.dart';
import 'package:sosnyp/pages/inbox.dart';
import 'package:sosnyp/pages/profile.dart';
import 'package:sosnyp/pages/accounts.dart';
import 'package:sosnyp/testing/testing.dart';

typedef Widget ZoomScaffoldBuilder(
    BuildContext context, MenuController menuController);

class Layout {
  final WidgetBuilder contentBuilder;

  Layout({
    this.contentBuilder,
  });
}

class MenuController extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;
  MenuState state = MenuState.closed;

  MenuController({
    this.vsync,
  }) : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 250)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
        }
        notifyListeners();
      });
  }

  get percentOpen {
    return _animationController.value;
  }

  close() {
    _animationController.reverse();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  open() {
    _animationController.forward();
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}

enum MenuState {
  closed,
  opening,
  open,
  closing,
}

class ZoomScaffold extends StatefulWidget {
  final Layout contentScreen;
  final Key contentkey;

  ZoomScaffold({
    this.contentScreen,
    this.contentkey,
  });

  @override
  _ZoomScaffoldState createState() => new _ZoomScaffoldState();
}

class ZoomScaffoldMenuController extends StatefulWidget {
  final ZoomScaffoldBuilder builder;

  ZoomScaffoldMenuController({
    this.builder,
  });

  @override
  ZoomScaffoldMenuControllerState createState() {
    return new ZoomScaffoldMenuControllerState();
  }
}

class ZoomScaffoldMenuControllerState
    extends State<ZoomScaffoldMenuController> {
  MenuController menuController;
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, getMenuController(context));
  }

  changeScreen(screen) {
    title = screen.toString();
    switch (screen) {
      case 'Home':
        x = HomePage();
        y = null;
        break;
      case 'Profile':
        x = ProfilePage();
        y = currentUserType == UserType.staff
            ? null
            : ProfilePage().popupMenu(rootContext);
        break;
      case 'DashBoard':
        x = DashBoardPage();
        y = null;
        break;
      case 'Inbox':
        x = InboxPage();
        y = null;
        break;
      case 'About':
        x = AboutPage();
        y = null;
        break;
      case 'Accounts':
        x = AccountPage();
        y = null;
        break;
      case 'Test':
        x = Test();
        y = null;
        break;
    }
  }

  @override
  void dispose() {
    menuController.removeListener(_onMenuControllerChange);
    super.dispose();
  }

  getMenuController(BuildContext context) {
    final scaffoldState =
        context.ancestorStateOfType(new TypeMatcher<_ZoomScaffoldState>())
            as _ZoomScaffoldState;
    return scaffoldState.menuController;
  }

  @override
  void initState() {
    super.initState();
    menuController = getMenuController(context);
    menuController.addListener(_onMenuControllerChange);
  }

  _onMenuControllerChange() {
    setState(() {});
  }
}

class _ZoomScaffoldState extends State<ZoomScaffold>
    with TickerProviderStateMixin {
  MenuController menuController;
  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  Widget build(BuildContext context) {
    getName();
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1350, allowFontScaling: true);

    return Stack(
      children: [
        Container(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            // resizeToAvoidBottomPadding: true,
            body: menu(context, menuController),
          ),
        ),
        GestureDetector(
            onTap: () {
              if (menuController.state == MenuState.open) {
                menuController.toggle();
              }
            },
            child: Container(
              child: createContentDisplay(),
            )),
      ],
    );
  }

  createContentDisplay() {
    return zoomAndSlideContent(new Container(
      child: new Scaffold(
        // resizeToAvoidBottomPadding: true,
        // resizeToAvoidBottomInset: false,
        key: widget.contentkey,
        appBar: new AppBar(
            elevation: 0.0,
            leading: new IconButton(
                icon: new Icon(
                  Icons.menu,
                ),
                onPressed: () {
                  menuController.toggle();
                }),
            actions: <Widget>[
              y == null ? Container() : y,
              y == null
                  ? Container()
                  : SizedBox(width: ScreenUtil.getInstance().setWidth(25))
            ],
            title: Container(
              child: Text(
                title == null ? "SOS NYP" : title,
                style: TextStyle(fontFamily: 'Black_label'),
              ),
            )),
        body: widget.contentScreen.contentBuilder(context),
      ),
    ));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  getName() async {
    var profileData = await Firestore.instance
        .collection('profile')
        .document(currentUser)
        .get();
    if (!profileData.exists) {
    } else {
      currentUserName = profileData.data['name'].toString();
    }
  }

  @override
  void initState() {
    super.initState();
    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  menu(BuildContext context, menuController) {
    final List<MenuItem> userOptions = [
      MenuItem(Icons.home, 'Home'),
      MenuItem(Icons.face, 'Profile'),
    ];
    final List<MenuItem> staffOptions = [
      MenuItem(Icons.inbox, 'Inbox'),
      MenuItem(Icons.dashboard, 'DashBoard'),
    ];
    final List<MenuItem> adminOptions = [
      MenuItem(Icons.adb, 'Test'),
      MenuItem(Icons.supervisor_account, 'Accounts'),
    ];

    return Container(
      height: ScreenUtil.getInstance().setHeight(1302),
      padding: EdgeInsets.only(
          top: ScreenUtil.getInstance().setHeight(80),
          left: ScreenUtil.getInstance().setWidth(50),
          bottom: ScreenUtil.getInstance().setWidth(5),
          right: MediaQuery.of(context).size.width / 2.9),
      child: Column(
        children: <Widget>[
          Container(
              height: ScreenUtil.getInstance().setHeight(90),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: currentUserImageUrl == null
                        ? Icon(
                            Icons.account_circle,
                            size: ScreenUtil.getInstance().setSp(80),
                          )
                        : CircularImage(NetworkImage(currentUserImageUrl)),
                  ),
                  Expanded(
                      child: AutoSizeText(
                    currentUserName == null ? 'h' : currentUserName,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(80),
                    ),
                  )),
                ],
              )),
          Spacer(),
          currentUserType == UserType.admin
              ? SizedBox(
                  height: ScreenUtil.getInstance().setHeight(50),
                  child: Center(
                    child: Text('User Functions'),
                  ))
              : Container(),
          if (currentUserType == UserType.admin ||
              currentUserType == UserType.user)
            Column(
              children: userOptions.map((item) {
                return ListTile(
                  onTap: () {
                    menuController.toggle();
                    ZoomScaffoldMenuControllerState().changeScreen(item.title);
                  },
                  leading: Icon(
                    item.icon,
                    size: 20,
                  ),
                  title: Text(item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                );
              }).toList(),
            ),
          currentUserType == UserType.admin
              ? SizedBox(
                  height: ScreenUtil.getInstance().setHeight(100),
                  child: Center(
                    child: Text('Staff Functions'),
                  ))
              : Container(),
          if (currentUserType == UserType.staff ||
              currentUserType == UserType.admin)
            Column(
              children: staffOptions.map((item) {
                return ListTile(
                  onTap: () {
                    menuController.toggle();
                    ZoomScaffoldMenuControllerState().changeScreen(item.title);
                  },
                  leading: Icon(
                    item.icon,
                    size: 20,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          currentUserType == UserType.admin
              ? SizedBox(
                  height: ScreenUtil.getInstance().setHeight(100),
                  child: Center(
                    child: Text('Admin Functions'),
                  ))
              : Container(),
          currentUserType == UserType.admin
              ? Column(
                  children: adminOptions.map((item) {
                    return ListTile(
                      onTap: () {
                        menuController.toggle();
                        ZoomScaffoldMenuControllerState()
                            .changeScreen(item.title);
                      },
                      leading: Icon(
                        item.icon,
                        size: 20,
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                )
              : Container(),
          Spacer(),
          ListTile(
            onTap: () {
              menuController.toggle();
              ZoomScaffoldMenuControllerState().changeScreen('About');
            },
            leading: Icon(
              Icons.help_outline,
              size: 20,
            ),
            title: Text('About',
                style: TextStyle(
                  fontSize: 14,
                )),
          ),
          ListTile(
            leading: Icon(
              Icons.power_settings_new,
              size: 20,
            ),
            title: Text('LogOut',
                style: TextStyle(
                  fontSize: 14,
                )),
            onTap: () {
              Firestore.instance
                  .collection('staffs')
                  .document(currentUser)
                  .delete();
              FirebaseAuth.instance.signOut().whenComplete(() {
                setState(() {
                  currentUserType = null;
                });
              });
            },
          ),
        ],
      ),
    );
  }

  zoomAndSlideContent(Widget content) {
    var slidePercent, scalePercent;
    switch (menuController.state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(menuController.percentOpen);
        scalePercent = scaleDownCurve.transform(menuController.percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(menuController.percentOpen);
        scalePercent = scaleUpCurve.transform(menuController.percentOpen);
        break;
    }

    final slideAmount = 275.0 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius = 16.0 * menuController.percentOpen;

    return new Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              offset: const Offset(0.0, 5.0),
              blurRadius: 15.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: new ClipRRect(
            borderRadius: new BorderRadius.circular(cornerRadius),
            child: content),
      ),
    );
  }
}
