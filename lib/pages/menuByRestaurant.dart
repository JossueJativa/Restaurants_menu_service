// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:flutter_demo_restaurant/widgets/cartBoxs.dart';
import 'package:flutter_demo_restaurant/widgets/redirections.dart';

class MenuByRestaurant extends StatefulWidget {
  final int idRestaurant;
  final String nameRestaurant;
  const MenuByRestaurant({ 
    Key? key,
    required this.idRestaurant,
    required this.nameRestaurant, 
  }) : super(key: key);

  @override
  _MenuByRestaurantState createState() => _MenuByRestaurantState();
}

class _MenuByRestaurantState extends State<MenuByRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Menu by ${widget.nameRestaurant}'),
      ),
      body: CartBoxsMenus(idRestaurant: widget.idRestaurant),

      floatingActionButton: const ShoppingCart(),
    );
  }
}