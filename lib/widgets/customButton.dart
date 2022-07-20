import 'package:flutter/material.dart';
import 'package:go_chat/constants.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({Key? key, this.text, required this.onPressed})
      : super(key: key);
  String? text;
  VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: kPrimaryColor),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
