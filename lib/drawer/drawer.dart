import 'package:firestoreproject/emailverifaction/login.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawericon extends StatefulWidget {
  const Drawericon({super.key});

  @override
  _DrawericonState createState() => _DrawericonState();
}

class _DrawericonState extends State<Drawericon> {
  String? userEmail;
  String? userProfilePic;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail');
      userProfilePic = prefs.getString('userProfilePic');
    });
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userEmail');
    await prefs.remove('userProfilePic');
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (userProfilePic != null && userProfilePic!.isNotEmpty)
                    CircleAvatar(
                      backgroundImage: NetworkImage(userProfilePic!),
                      radius: 40,
                    )
                  else
                    const Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  const SizedBox(height: 10),
                  if (userEmail != null)
                    Text(
                      userEmail!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Sora",
                      ),
                    )
                ],
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
                await logout(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
