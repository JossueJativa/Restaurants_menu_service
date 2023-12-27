// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_demo_restaurant/services/joinToApp.dart';
import 'package:flutter_demo_restaurant/widgets/input.dart';
import 'package:flutter_demo_restaurant/widgets/messages.dart';
import 'package:flutter_demo_restaurant/widgets/redirections.dart';

class RegisterViewSet extends StatefulWidget {
  const RegisterViewSet({super.key});

  @override
  State<RegisterViewSet> createState() => _RegisterViewSetState();
}

class _RegisterViewSetState extends State<RegisterViewSet> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController address = TextEditingController();
  late bool register;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InputInformation(
              labelText: 'Username',
              hintText: 'Username',
              controller: username,
            ),
                
            InputInformation(
              labelText: 'Email',
              hintText: 'Email',
              controller: email,
            ),
                
            InputInformation(
              labelText: 'Phone', 
              hintText: 'Phone',
              controller: phone,
            ),
                
            InputInformation(
              labelText: 'Password',
              hintText: 'Password',
              isPassword: true,
              controller: password,
            ),
                
            InputInformation(
              labelText: 'Confirm Password',
              hintText: 'Confirm Password',
              isPassword: true,
              controller: confirmPassword,
            ),
                
            InputInformation(
              labelText: 'Address',
              hintText: 'Address',
              controller: address,
            ),
                
            NormalButton(
              text: "Register",
              onPressed: () async {
                Map<String, String> result = await Register_user(
                  username.text,
                  email.text,
                  phone.text,
                  password.text,
                  confirmPassword.text,
                  address.text,
                );
                
                if (result['result'] == 'success') {
                  successMessage(context, result['message']!);
                  Navigator.popAndPushNamed(context, 'login');
                  // Aquí puedes realizar acciones adicionales después del registro exitoso
                } else {
                  errorMessage(context, result['message']!);
                  // Aquí puedes realizar acciones adicionales en caso de error
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}