import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    await firebase(FirebaseAuth.instance).resetpassword(
      email: emailcontroller.text,
      context: context,
    );
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signin()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Your Email"),
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: TextFormField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    email = emailcontroller.text;
                  });
                  resetPassword();
                }
              },
              child: Text(
                "Send Email",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
