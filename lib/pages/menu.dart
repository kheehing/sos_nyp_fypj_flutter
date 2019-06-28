import 'package:firebase_auth/firebase_auth.dart';
import 'package:sosnyp/functions/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:sosnyp/functions/zoom_scaffold.dart';
import 'package:sosnyp/main.dart';
// import 'package:sosnyp/main.dart';

class MenuScreen extends StatelessWidget {
  final String imageUrl =
      "https://celebritypets.net/wp-content/uploads/2016/12/Adriana-Lima.jpg";

  final List<MenuItem> options = [
    MenuItem(Icons.home, 'Home'),
    MenuItem(Icons.face, 'Profile'),
    MenuItem(Icons.text_fields, 'Testing'),
  ];
  final List<MenuItem> adminOptions = [
    MenuItem(Icons.dashboard, 'DashBoard'),
    MenuItem(Icons.face, 'Inbox'),
    MenuItem(Icons.group_add, 'Register'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 62,
          left: 32,
          bottom: 8,
          right: MediaQuery.of(context).size.width / 2.9),
      color: Color(0xff454dff),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CircularImage(
                  NetworkImage(imageUrl),
                ),
              ),
              Text(
                'Tatiana',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )
            ],
          ),
          Spacer(),
          Column(
            children: options.map((item) {
              return ListTile(
                onTap: () {
                  // menuController.close();
                  Navigator.popAndPushNamed(
                      context, '/' + item.title.toString());
                },
                leading: Icon(
                  item.icon,
                  color: Colors.white,
                  size: 20,
                ),
                title: Text(
                  item.title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              );
            }).toList(),
          ),
          if (currentUser == "Sa7pRwTTNWgFks2ETFHIWJ84AIA2") Spacer(),
          if (currentUser == "Sa7pRwTTNWgFks2ETFHIWJ84AIA2")
            Column(
              children: adminOptions.map((item) {
                return ListTile(
                  onTap: () {
                    // menuController.close();
                    Navigator.popAndPushNamed(
                        context, '/' + item.title.toString());
                  },
                  leading: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          Spacer(),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.settings,
              color: Colors.white,
              size: 20,
            ),
            title: Text('Settings',
                style: TextStyle(fontSize: 14, color: Colors.white)),
          ),
          ListTile(
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.white,
              size: 20,
            ),
            title: Text('LogOut',
                style: TextStyle(fontSize: 14, color: Colors.white)),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              });
            },
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.icon, this.title);
}
