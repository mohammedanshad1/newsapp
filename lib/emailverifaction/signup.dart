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
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 void signUpUser() async {
    if (_formKey.currentState!.validate()) {
      firebase(FirebaseAuth.instance).signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context);
    }
  }

  void signInWithGoogle() async {
    firebase(FirebaseAuth.instance).signInWithGoogle(context);
  }


  bool showPass = true;
  bool showConfirmPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Let's get Started!",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "Sora", fontSize: 18),
                  ),
                ),
                const Center(
                  child: Text(
                    "Create your own account",
                    style: TextStyle(
                        color: Colors.black, fontSize: 18, fontFamily: "Sora"),
                  ),
                ),
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
                      if (email == null || email.isEmpty) {
                        return "Enter a valid email";
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
                          borderRadius: BorderRadius.circular(22)),
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
                        return "Enter a valid password";
                      }
                      if (pass.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    obscuringCharacter: "*",
                    obscureText: showConfirmPass,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelText: "Confirm Password",
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showConfirmPass = !showConfirmPass;
                          });
                        },
                        icon: Icon(
                          showConfirmPass
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: (cpass) {
                      if (cpass == null || cpass.isEmpty) {
                        return "Enter a valid password";
                      }
                      if (cpass != passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                GestureDetector(
                  onTap: signUpUser,
                  child: Container(
                    height: 40,
                    width: 310,
                    decoration: BoxDecoration(
                        color: HexColor("303050"),
                        borderRadius: BorderRadius.circular(22)),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style:
                            TextStyle(color: Colors.white, fontFamily: "Sora"),
                      ),
                    ),
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
                        ),
                      ),
                      Text("or  "),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          height: 1,
                          thickness: 1,
                          endIndent: 10,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: const Text(
                    "Already have an account? Sign in",
                    style: TextStyle(color: Colors.black, fontFamily: "Sora"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
