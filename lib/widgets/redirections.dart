import 'package:flutter/material.dart';
import 'package:flutter_demo_restaurant/services/counterCart.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const NormalButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: (){
          onPressed();
        }, 
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        )
      ),
    );
  }
}

class RedirectText extends StatelessWidget {
  final String text;
  final Function onPressed;
  const RedirectText({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          onPressed();
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
    );
  }
}

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: countCart(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error al obtener la cantidad del carrito');
        } else {
          final itemCount = snapshot.data ?? 0;

          return Stack(
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'cart');
                },
                backgroundColor: Colors.cyan,
                child: const Icon(Icons.shopping_cart),
              ),
              if (itemCount > 0)
                Positioned(
                  top: -5.0,
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      itemCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}