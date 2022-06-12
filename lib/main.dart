import 'package:flutter/material.dart';
import 'package:inno_cart/GenerateRoute.dart';
import 'package:inno_cart/pageOfAngelOrders.dart';
import 'package:inno_cart/pageOfShopperOrders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/AngelOrders',
      onGenerateRoute: generateRoute,
    );
  }
}

/*
*/
