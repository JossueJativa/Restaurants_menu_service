// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_demo_restaurant/widgets/cartBoxs.dart';
import 'package:flutter_demo_restaurant/widgets/redirections.dart';

class FoodByMenu extends StatefulWidget {
  final int idMenu;
  final String nameMenu;
  const FoodByMenu({ 
    Key? key,
    required this.idMenu,
    required this.nameMenu,
  }) : super(key: key);

  @override
  _FoodByMenuState createState() => _FoodByMenuState();
}

class _FoodByMenuState extends State<FoodByMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Menu by ${widget.nameMenu}'),
      ),
      body: CartBoxsFoods(idMenu: widget.idMenu),

      floatingActionButton: const ShoppingCart(),
    );
  }
}