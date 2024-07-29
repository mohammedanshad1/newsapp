import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: HexColor("#08153c"),
      duration: Duration(seconds: 3),
    ),
  );
}
