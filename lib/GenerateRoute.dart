import 'package:flutter/material.dart';
import 'package:inno_cart/hello_screen.dart';
import 'package:inno_cart/registration_screen.dart';
import 'PageOfActiveOrders.dart';
import 'pageOfAngelOrders.dart';
import 'pageOfShopperOrders.dart';
import 'logging_page.dart';

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final data = settings.arguments;
      return MaterialPageRoute(builder: (_) => const helloPage());
    case '/OrdersPage':
      return MaterialPageRoute(builder: (_) => const PageOfActiveOrders());
    case '/PageOfActiveOrders':
      return MaterialPageRoute(builder: (_) => const PageOfAngelOrders());
    case '/ShopperOrders':
      return MaterialPageRoute(builder: (_) => const PageOfShopperOrders());
    case '/RegistrattionPage':
      return MaterialPageRoute(builder: (_) => regScreen());
    case '/LogInPage':
      return MaterialPageRoute(builder: (_) => LogInPage());

    default:
      return null;
  }
}
