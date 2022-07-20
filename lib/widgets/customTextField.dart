import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    required this.obscureText,
  }) : super(key: key);
  String? label;
  Icon? prefixIcon;
  Icon? suffixIcon;
  dynamic keyboardType;
  bool obscureText;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is required';
          }
        },
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon),
      ),
    );
  }
}
