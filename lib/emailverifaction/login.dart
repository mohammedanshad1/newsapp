import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestoreproject/emailverifaction/forgotpassword.dart';
import 'package:firestoreproject/emailverifaction/signup.dart';
import 'package:firestoreproject/emailverifaction/snackbar.dart';
import 'package:firestoreproject/view/news_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';

import 'firehelper.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showPass = true;

  void signInUser() async {
    if (formKey.currentState!.validate()) {
      try {
        await firebase(FirebaseAuth.instance).loginWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
      } catch (e) {
        showSnackBar(context, e.toString());
      }
    }
  }

  void signInWithGoogle() async {
    try {
      await firebase(FirebaseAuth.instance).signInWithGoogle(context);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Welcome back",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Sora",
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Login to your account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "Sora",
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        prefixIcon: const Icon(Icons.person),
                        labelText: "Email",
                      ),
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return "Enter valid email";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      obscuringCharacter: "*",
                      obscureText: showPass,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPass = !showPass;
                            });
                          },
                          icon: Icon(
                            showPass ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                      validator: (pass) {
                        if (pass == null || pass.isEmpty) {
                          return "Enter valid password";
                        }
                        if (pass.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 0),
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
                                        const Forgotpassword(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(fontFamily: "Sora"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onTap: signInUser,
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
                  GestureDetector(
                    onTap: signInWithGoogle,
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
