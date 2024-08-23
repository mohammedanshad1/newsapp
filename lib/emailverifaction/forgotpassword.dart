import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'firehelper.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  String email = "";
  TextEditingController emailcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void resetPassword() async {
    await firebase(FirebaseAuth.instance).resetPassword(
      email: emailcontroller.text,
      context: context,
    );
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signin()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Forgot Passowrd",
              style: TextStyle(fontFamily: "Sora", fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22)),
                  hintText: "Email",
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    email = emailcontroller.text;
                  });
                  resetPassword();
                }
              },
              child: Container(
                height: 40,
                width: 290,
                decoration: BoxDecoration(
                    color: HexColor("303050"),
                    borderRadius: BorderRadius.circular(22)),
                child: Center(
                    child: Text(
                  "Send Email",
                  style: TextStyle(color: Colors.white, fontFamily: "Sora"),
                )),
              ),
            ),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
            //   onPressed: () {
            //     if (_formkey.currentState!.validate()) {
            //       setState(() {
            //         email = emailcontroller.text;
            //       });
            //       resetPassword();
            //     }
            //   },
            //   child: Text(
            //     "Send Email",
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
