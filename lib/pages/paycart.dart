// ignore_for_file: library_private_types_in_public_api, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_demo_restaurant/services/paymentlogic.dart';

class Paycart extends StatefulWidget {
  const Paycart({ Key? key }) : super(key: key);

  @override
  _PaycartState createState() => _PaycartState();
}

class _PaycartState extends State<Paycart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de Pago'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreditCardWidget(
                cardNumber: '4111111111111111',
                expiryDate: '04/24',
                cardHolderName: 'John Doe',
                cvvCode: '123',
                // ignore: non_constant_identifier_names
                showBackView: false, onCreditCardWidgetChange: (CreditCardBrand ) {  },
              ),
              const SizedBox(height: 20),
              const Text(
                'Información de la Tarjeta',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre en la Tarjeta'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Número de la Tarjeta'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Fecha de Expiración'),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    flex: 1,
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'CVV'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Acción a realizar al presionar el botón de pagar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
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
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  makePaymentInCash();
                  Navigator.popAndPushNamed(context, 'home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Pagar en caja',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]
      ),
    );
  }
}