// ignore_for_file: file_names, unnecessary_null_comparison, use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_demo_restaurant/pages/foodByMenu.dart';
import 'package:flutter_demo_restaurant/pages/menuByRestaurant.dart';
import 'package:flutter_demo_restaurant/services/productsByRestaurant.dart';
import 'package:flutter_demo_restaurant/widgets/messages.dart';

class MenuItemWidget extends StatefulWidget {
  final String photo;
  final String name;
  final String price;
  final int id;

  const MenuItemWidget({
    required this.photo,
    required this.name,
    required this.price,
    required this.id,
  });

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align left and right
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Image.network(
                    widget.photo,
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.price != null) ...[
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            if (quantity > 0) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                        ),
                        Text(
                          '$quantity',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                addFoodToCart(widget.id, quantity);
                Navigator.pushReplacementNamed(
                  context,
                  'home'
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantContainerWidget extends StatelessWidget {
  final String photo;
  final String name;
  final String address;
  final VoidCallback onPressed;

  const RestaurantContainerWidget({
    required this.photo,
    required this.name,
    required this.address,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        color: Colors.cyan,
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              photo,
              width: 100,
              height: 100,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    address,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: onPressed,
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
              return RestaurantContainerWidget(
                photo: restaurants['photo'],
                name: restaurants['name'],
                address: restaurants['address'],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuByRestaurant(
                        idRestaurant: restaurants['id'],
                        nameRestaurant: restaurants['name'],
                      ),
                    ),
                  );
                },
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
                                Navigator.push(context, 
                                  MaterialPageRoute(
                                    builder: (context) => FoodByMenu(
                                      idMenu: menus['id'],
                                      nameMenu: menus['name'],
                                    ),
                                  ),
                                );
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

class CartBoxsFoods extends StatelessWidget {
  final int idMenu;
  const CartBoxsFoods({
    required this.idMenu,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return FutureBuilder(
      future: getFoodsByMenu(idMenu),
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
          final List<dynamic>? foodList = snapshot.data;

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: foodList!.length,
            itemBuilder: (BuildContext context, int index) {
              final menus = foodList[index];
              return MenuItemWidget(
                photo: menus['photo'],
                name: menus['name'],
                price: menus['price'].toString(),
                id: menus['id'],
              );
            },
          );
        }
      },
    );
  }
}

class CartBoxsCart extends StatelessWidget {
  const CartBoxsCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCart(),
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
          final List<dynamic>? cartList = snapshot.data;

          return ListView.builder(
            itemCount: cartList!.length,
            itemBuilder: (BuildContext context, int index) {
              final cartItem = cartList[index];

              return CartItemWidget(
                id: cartItem['id'],
                quantity: cartItem['quantity'],
                total: cartItem['total'],
                status: cartItem['status'],
                restaurant: cartItem['restaurant'],
                dish: cartItem['dish'],
                photoDish: cartItem['photoDish'],
              );
            },
          );
        }
      },
    );
  }
}

class CartItemWidget extends StatefulWidget {
  final int quantity;
  final double total;
  final String status;
  final String restaurant;
  final String dish;
  final String photoDish;
  final int id;

  const CartItemWidget({
    required this.quantity,
    required this.total,
    required this.status,
    required this.restaurant,
    required this.dish,
    required this.photoDish,
    required this.id,
  });

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.photoDish,
                width: 100,
                height: 100,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cantidad: ${widget.quantity}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Estado: ${widget.status}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Restaurante: ${widget.restaurant}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Plato: ${widget.dish}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total: ${widget.total}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if(widget.quantity > 1) {
                              int currentQuantity = widget.quantity - 1;
                              updateCart(widget.id, currentQuantity);
                              informationMessage(context,
                                '${widget.dish} eliminado 1',
                              );
                              Navigator.pushReplacementNamed(context, 'cart');
                            }
                          });
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            int currentQuantity0 = widget.quantity + 1;
                            updateCart(widget.id, currentQuantity0);
                            informationMessage(context,
                              '${widget.dish} agregado 1',
                            );
                            Navigator.pushReplacementNamed(context, 'cart');
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          deleteCartFood(widget.id);
                          Navigator.pushReplacementNamed(context, 'cart');
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckoutBox extends StatelessWidget {
  const CheckoutBox({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getTotalCart(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          double total = snapshot.data?['total'] ?? 0.0;
          return Container(
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$ ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Pagar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}