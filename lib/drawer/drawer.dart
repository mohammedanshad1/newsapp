import 'package:firestoreproject/emailverifaction/login.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawericon extends StatelessWidget {
  const Drawericon({
    super.key,
  });
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: HexColor("303050"),
            border: const Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.0,
              ),
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: ListTile(
            title: const Text(
              "H O M E",
              style: TextStyle(fontFamily: "Sora"),
            ),
            leading: const Icon(Icons.home),
            onTap: () {
              //pop the drawer
              Navigator.pop(context);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: ListTile(
            title: const Text(
              "S E T T I N G S",
              style: TextStyle(fontFamily: "Sora"),
            ),
            leading: const Icon(Icons.settings),
            onTap: () {
              //pop the drawer
              Navigator.pop(context);
            },
          ),
        ),
        const Spacer(),
        Container(
          color: HexColor("303050"),
          child: ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Sora",
              ),
            ),
            onTap: () async {
              // Handle logout action
              logout(context);
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Login())); // Navigate to login screen
            },
          ),
        )
      ]),
    );
  }
}
