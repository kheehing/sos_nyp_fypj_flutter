import 'package:flutter/material.dart';
// import 'auth_provider.dart';
import 'auth.dart';
// import 'home.dart';
import 'login.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus _authStatus = AuthStatus.notSignedIn;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final BaseAuth auth = AuthProvider.of(context).auth;
  //   auth.currentUser().then((String userId) {
  //     setState(() {
  //       _authStatus =
  //           userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
  //     });
  //   });
  // }
  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  // void _signedIn() {
  //   setState(() {
  //     _authStatus = AuthStatus.signedIn;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
        );
      case AuthStatus.signedIn:
        return new Scaffold(
          body: new Container(
            child: Text('success'),
          ),
        );
    }
  }

  // Widget _buildWaitingScreen() {
  //   return Scaffold(
  //     body: Container(
  //       alignment: Alignment.center,
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }
}
