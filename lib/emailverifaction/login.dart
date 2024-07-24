import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestoreproject/emailverifaction/forgotpassword.dart';
import 'package:firestoreproject/emailverifaction/signup.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  GlobalKey<FormState>formkey=GlobalKey();
  bool showpass=true;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                  child: Text(
                "Welcome back ",
                style: TextStyle(
                    color: Colors.black, fontFamily: "Sora", fontSize: 20),
              )),
              Center(
                  child: Text(
                " login to your account ",
                style: TextStyle(color: Colors.black, fontSize: 18,fontFamily: "Sora"),
              )),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),prefixIcon: Icon(Icons.person),
                      labelText: "Email"), validator: (email){
                  if(email!.isEmpty || email.contains("#")|| email.contains("/")){
                    return "Enter valid username";
                  }
                  else{
                    return null;
                  }
                }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(obscuringCharacter: "*",obscureText: showpass,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22)),
                      labelText: "Password",
                    prefixIcon: Icon(Icons.password),suffixIcon: IconButton(onPressed:(){setState(() {

                    if(showpass){
                      showpass=false;
                    }
                    else{
                      showpass=true;
                    }
                  }

                  );},
                    icon: Icon(showpass==true ? Icons.visibility_off:Icons.visibility),),

                  ),validator: (pass){
                      if(pass!.isEmpty || pass.contains("#")|| pass.contains("/")){
                        return "Enter valid password";
                      }
                      else{
                        return null;
                      }
                    }
                ),
              ),
              SizedBox(
                height: 0,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text("Remember Me",style: TextStyle(fontFamily: "Sora"),),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Forgotpassword()));
                          },
                          child: Text("Forgot Passowrd?",style: TextStyle(fontFamily: "Sora"),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 70,
              ),
              GestureDetector(
                onTap: () {
                  signInUser();
                },
                child: Container(
                  height: 40,
                  width: 310,
                  decoration: BoxDecoration(
                      color: HexColor("303050"),
                      borderRadius: BorderRadius.circular(22)),
                  child: Center(
                      child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white,fontFamily: "Sora"),
                  )),
                ),
              ),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(backgroundColor:HexColor("303050"),),
              //     onPressed: () {
              //       signInUser();
              //     },
              //     child: Text("Login")),
              // SizedBox(
              //   height: 20,
              // ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
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
              SizedBox(
                height: 30,
              ),
              Container(
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sign with Google',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Signup()));
                  },
                  child: Text(
                    "Don't have an account?Sign up",
                    style: TextStyle(color: Colors.black,fontFamily: "Sora"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
