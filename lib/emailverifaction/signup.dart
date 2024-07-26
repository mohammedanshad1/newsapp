// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestoreproject/emailverifaction/login.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'firehelper.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signUpUser() async {
    firebase(FirebaseAuth.instance).signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  void signInWithGoogle() async {
    firebase(FirebaseAuth.instance).signInWithGoogle(context);
  }

  bool showpass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 90),
        child: Column(children: [
          const Center(
              child: Text(
            "Let's get Started!",
            style: TextStyle(
                color: Colors.black, fontFamily: "Sora", fontSize: 18),
          )),
          const Center(
              child: Text(
            " Create your own account ",
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontFamily: "Sora"),
          )),
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22)),
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (email) {
                  if (email == null ||
                      email.isEmpty ||
                      email.contains("#") ||
                      email.contains("/")) {
                    return "Enter valid username";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                    return 'Please enter a valid email address';
                  } else {
                    return null;
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                obscuringCharacter: "*",
                obscureText: showpass,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22)),
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (showpass) {
                          showpass = false;
                        } else {
                          showpass = true;
                        }
                      });
                    },
                    icon: Icon(showpass == true
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                validator: (pass) {
                  if (pass == null ||
                      pass.isEmpty ||
                      pass.contains("#") ||
                      pass.contains("/")) {
                    return "Enter valid password";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(pass)) {
                    return 'Please enter a valid email address';
                  } else {
                    return null;
                  }
                }),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22)),
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.password),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        if (showpass) {
                          showpass = false;
                        } else {
                          showpass = true;
                        }
                      });
                    },
                    icon: Icon(showpass == true
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
                validator: (pass) {
                  if (pass == null ||
                      pass.isEmpty ||
                      pass.contains("#") ||
                      pass.contains("/")) {
                    return "Enter valid password";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(pass)) {
                    return 'Please enter a valid email address';
                  } else {
                    return null;
                  }
                }),
          ),

          const SizedBox(
            height: 70,
          ),

          GestureDetector(
            onTap: () {
              signUpUser();
            },
            child: Container(
              height: 40,
              width: 310,
              decoration: BoxDecoration(
                  color: HexColor("303050"),
                  borderRadius: BorderRadius.circular(22)),
              child: const Center(
                  child: Text(
                "Create account",
                style: TextStyle(color: Colors.white, fontFamily: "Sora"),
              )),
            ),
          ),
          // ElevatedButton(
          //     style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          //     onPressed: () {
          //       signUpUser();
          //     },
          //
          //     child: Text("Sign Up")),

          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                )),
                Text("or  "),
                Expanded(
                    child: Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 1,
                  endIndent: 10,
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(onTap: signInWithGoogle,
            child: Container(
              height: 40,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(width: 1, color: Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/Google__G__logo.svg.png',
                    height: 30,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Sign with Google',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: const Text(
                "Already have an account?Sign in",
                style: TextStyle(color: Colors.black, fontFamily: "Sora"),
              )),
        ]),
      ),
    ));
  }
}
