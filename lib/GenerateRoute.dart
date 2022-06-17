import 'package:flutter/material.dart';
import 'package:inno_cart/hello_screen.dart';
import 'package:inno_cart/profile_change_screen.dart';
import 'package:inno_cart/profile_screen.dart';
import 'package:inno_cart/registration_screen.dart';
import 'PageOfActiveOrders.dart';
import 'pageOfAngelOrders.dart';
import 'pageOfShopperOrders.dart';
import 'logging_page.dart';
import 'creating_order_screen.dart';
import 'profile_change_screen.dart';
Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final data = settings.arguments;
      return MaterialPageRoute(builder: (_) => const helloPage());
    case '/PageOfActiveOrders':
      return MaterialPageRoute(builder: (_) => const PageOfActiveOrders());
    case '/AngelOrders':
      return MaterialPageRoute(builder: (_) => const PageOfAngelOrders());
    case '/ShopperOrders':
      return MaterialPageRoute(builder: (_) => const PageOfShopperOrders());
    case '/RegistrattionPage':
      return MaterialPageRoute(builder: (_) => regScreen());
    case '/LogInPage':
      return MaterialPageRoute(builder: (_) => LogInPage());
    case '/CreatingOrderScreen':
      return MaterialPageRoute(builder: (_) => OrderFactoryPage());
    case '/ProfileScreen':
      return MaterialPageRoute(builder: (_) => ProfilePage());
    case '/ProfileChangeScreen':
      return MaterialPageRoute(builder: (_) => ProfileChangeScreen());
    default:
      return null;
  }
}
