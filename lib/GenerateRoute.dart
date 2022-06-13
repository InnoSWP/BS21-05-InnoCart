import 'package:flutter/material.dart';
import 'PageOfActiveOrders.dart';
import 'pageOfAngelOrders.dart';
import 'pageOfShopperOrders.dart';

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final data = settings.arguments;
      return MaterialPageRoute(builder: (_) => const PageOfActiveOrders());
    case '/AngelOrders':
      return MaterialPageRoute(builder: (_) => const PageOfAngelOrders());
    case '/ShopperOrders':
      return MaterialPageRoute(builder: (_) => const PageOfShopperOrders());
    default:
      return null;
  }
}
