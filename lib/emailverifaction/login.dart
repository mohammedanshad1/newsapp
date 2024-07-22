

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestoreproject/emailverifaction/forgotpassword.dart';
import 'package:firestoreproject/emailverifaction/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'firehelper.dart';



class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signInUser() async {
    firebase(FirebaseAuth.instance).loginWithEmail(email: emailController.text,
        password: passwordController.text,
        context: context);



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In"),),

      body: Column(children: [

        Center(child: Text("Login", style: TextStyle(
            color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 30),)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: emailController,
            decoration: InputDecoration(border: OutlineInputBorder(),
                labelText: "Email"),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(controller: passwordController,
            decoration: InputDecoration(border: OutlineInputBorder(),
                labelText: "Password"),),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            onPressed: () {
              signInUser();
            }, child: Text("Login")),
        SizedBox(height: 20,),
        TextButton(onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Forgotpassword()));
        }, child: Text("Forgot Passowrd")),

        TextButton(onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Signup()));
        }, child: Text("Create New Account")),



      ],),
    );
  }
}