import 'package:flutter/material.dart';

class drawerwidget extends StatelessWidget {
  const drawerwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("surend"),
            accountEmail: Text("surenkutty"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("SK"),
            ),
          ),
          ListTile(
            title: Text("Contect"),
            leading: Icon(Icons.email),
          ),
          Divider(
            height: 0.1,
          ),
          //

          ListTile(
            title: Text("Settings"),
            leading: Icon(Icons.settings),
          ),
          Divider(
            height: 0.1,
          ),
          //logout
          ListTile(
            title: Text("Logout"),
            leading: Icon(Icons.logout),
          ),
          Divider(
            height: 0.1,
          )
        ],
      ),
    );
  }
}
