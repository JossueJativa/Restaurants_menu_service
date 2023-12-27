import 'package:flutter/material.dart';
import 'package:flutter_demo_restaurant/widgets/cartBoxs.dart';

class HomeViewSet extends StatefulWidget {
  const HomeViewSet({super.key});

  @override
  State<HomeViewSet> createState() => _HomeViewSetState();
}

class _HomeViewSetState extends State<HomeViewSet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurantes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, 'login');
            },
            icon: const Icon(Icons.logout)
          ),
        ],
      ),

      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ContainerRestaurants(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}