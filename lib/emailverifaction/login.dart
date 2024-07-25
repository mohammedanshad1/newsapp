// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestoreproject/emailverifaction/forgotpassword.dart';
import 'package:firestoreproject/emailverifaction/signup.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'firehelper.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signInUser() async {
    firebase(FirebaseAuth.instance).loginWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }
  void signInWithGoogle() async {
    firebase(FirebaseAuth.instance).signInWithGoogle(context);
  }

  @override
  GlobalKey<FormState> formkey = GlobalKey();
  bool showpass = true;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Center(
                      child: Text(
                    "Welcome back ",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Sora", fontSize: 20),
                  )),
                  const Center(
                      child: Text(
                    " login to your account ",
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
                            prefixIcon: const Icon(Icons.person),
                            labelText: "Email"),
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
                  const SizedBox(
                    height: 0,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Text(
                              "Remember Me",
                              style: TextStyle(fontFamily: "Sora"),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Forgotpassword()));
                              },
                              child: const Text(
                                "Forgot Passowrd?",
                                style: TextStyle(fontFamily: "Sora"),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onTap:signInUser,
                    child: Container(
                      height: 40,
                      width: 310,
                      decoration: BoxDecoration(
                          color: HexColor("303050"),
                          borderRadius: BorderRadius.circular(22)),
                      child: const Center(
                          child: Text(
                        "Sign In",
                        style:
                            TextStyle(color: Colors.white, fontFamily: "Sora"),
                      )),
                    ),
                  ),
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
                    height: 30,
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
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: const Text(
                        "Don't have an account?Sign up",
                        style:
                            TextStyle(color: Colors.black, fontFamily: "Sora"),
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
