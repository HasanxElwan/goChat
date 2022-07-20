import 'package:flutter/material.dart';
import 'package:go_chat/constants.dart';

void showSnackBar(BuildContext context, String message) {
  String messages = message;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kPrimaryColor,
      content: Text(messages),
    ),
  );
}
