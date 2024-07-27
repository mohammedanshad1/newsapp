import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Sora',
        ),
      ),
      backgroundColor: Color(0xFF303050),
    ),
  );
}