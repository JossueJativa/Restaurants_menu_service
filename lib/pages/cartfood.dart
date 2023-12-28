// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_demo_restaurant/widgets/cartBoxs.dart';

class Cartfood extends StatefulWidget {
  const Cartfood({ Key? key }) : super(key: key);

  @override
  _CartfoodState createState() => _CartfoodState();
}

class _CartfoodState extends State<Cartfood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text('Cart'),
      ),

      body: const CartBoxsCart(),
    );
  }
}