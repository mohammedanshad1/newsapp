
import 'package:firestoreproject/emailverifaction/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homes extends StatelessWidget{
  final String email;

  homes({Key? key,required this.email});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Home Page"),centerTitle: true,
      leading: GestureDetector(onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
      },
          child: Icon(Icons.arrow_back)),),

      body: Column(
        children: [
          Center(child: Text("Welcome $email",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,
              fontSize: 25),)),
        ],
      ),
    );
  }
}