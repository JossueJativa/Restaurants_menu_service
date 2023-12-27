// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_demo_restaurant/pages/menuByRestaurant.dart';
import 'package:flutter_demo_restaurant/services/productsByRestaurant.dart';

class CointainerMenuProduct extends StatelessWidget {
  final String photo;
  final String price;
  final String name;
  const CointainerMenuProduct({
    super.key,
    required this.photo,
    required this.price,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: Colors.cyan,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Row(
          children: [
            Image(
              image: NetworkImage(photo),
              width: 100,
              height: 100,
            ),
      
            Padding(
              padding: const EdgeInsets.fromLTRB(45.0, 0, 0, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                
                    ElevatedButton(
                      onPressed: (){
                
                      }, 
                      child: const Text(
                        "Add to cart",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}

class ContainerRestaurants extends StatelessWidget {
  const ContainerRestaurants({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRestaurants(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No hay datos disponibles.'),
          );
        } else {
          final List<dynamic>? restaurantList = snapshot.data;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: restaurantList!.length,
            itemBuilder: (BuildContext context, int index) {
              final restaurants = restaurantList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  color: Colors.cyan,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        restaurants['photo'],
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurants['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              restaurants['address'],
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, 
                                  MaterialPageRoute(
                                    builder: (context) => MenuByRestaurant(
                                      idRestaurant: restaurants['id'],
                                      nameRestaurant: restaurants['name'],
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Ver menús",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

class CartBoxsMenus extends StatelessWidget {
  final int idRestaurant;
  const CartBoxsMenus({ 
    required this.idRestaurant,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: getMenusByRestaurant(idRestaurant),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No hay datos disponibles.'),
          );
        } else {
          final List<dynamic>? menusList = snapshot.data;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menusList!.length,
            itemBuilder: (BuildContext context, int index) {
              final menus = menusList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  color: Colors.cyan,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        menus['photo'],
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menus['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Navigator.push(context, 
                                //   MaterialPageRoute(
                                //     builder: (context) => MenuByRestaurant(
                                //       idRestaurant: menus['id'],
                                //     ),
                                //   ),
                                // );
                              },
                              child: const Text(
                                "Ver platos",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}