import 'package:flutter/material.dart';

class InputInformation extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  const InputInformation({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    required this.controller
  }) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20,0,20,0),
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
        ),
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
      ),
    );
  }
}