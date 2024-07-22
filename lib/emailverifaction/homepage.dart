
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homes extends StatelessWidget{
  final String email;

  homes({Key? key,required this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Home Page"),),

      body: Column(
        children: [
          Center(child: Text("Welcome $email",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,
              fontSize: 25),)),
        ],
      ),
    );
  }
}