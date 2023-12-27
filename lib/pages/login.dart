// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_demo_restaurant/services/joinToApp.dart';
import 'package:flutter_demo_restaurant/widgets/input.dart';
import 'package:flutter_demo_restaurant/widgets/messages.dart';
import 'package:flutter_demo_restaurant/widgets/redirections.dart';

class LoginViewSet extends StatefulWidget {
  const LoginViewSet({super.key});

  @override
  State<LoginViewSet> createState() => _LoginViewSetState();
}

class _LoginViewSetState extends State<LoginViewSet> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Image.network(
                'https://images.rappi.com.ec/restaurants_logo/smiles-logo1-1596481275314-1596662696295-1597699694717.png?e=webp&d=10x10&q=10',
                width: 100,
                height: 100,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ElevatedButton(onPressed: (){
            
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('Login with google account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            
                Image.network( 'https://th.bing.com/th/id/R.96c1a6566397efcf7de758fd2a6f116a?rik=LwK4OM1JQPW06A&pid=ImgRaw&r=0',
                  width: 20,
                  height: 20,
                ),
              ]
            )),
          ),

          const Text('or'),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: ElevatedButton(onPressed: (){
            
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text('Login with google account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            
                Image.network( 'https://th.bing.com/th/id/R.301c77301df4fa0170c3caf2e990541f?rik=Vw5l3fZFDfdNOA&pid=ImgRaw&r=0',
                  width: 40,
                  height: 40,
                ),
              ]
            )),
          ),

          const Text('or'),

          InputInformation(
            labelText: 'Email',
            hintText: 'Email',
            controller: email,
          ),

          InputInformation(
            labelText: 'Password',
            hintText: 'Password',
            isPassword: true,
            controller: password,
          ),

          const SizedBox(height: 20,),

          NormalButton(
            text: "Login",
            onPressed: () async {
              Map<String, String> data = await Login_user(
                email.text,
                password.text,
              );

              if (data['result'] == 'success') {
                Navigator.popAndPushNamed(context, 'home');
              } else {
                errorMessage(context, data['message']!);
              }
            }
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account?'),

              RedirectText(onPressed: (){
                Navigator.pushNamed(context, 'register');
              },
              text: 'Register',)
            ],
          )
        ],
      ),
    );
  }
}