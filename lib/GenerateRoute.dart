import 'package:flutter/material.dart';
import 'package:inno_cart/pageOfAngelOrders.dart';
import 'package:inno_cart/pageOfShopperOrders.dart';

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final data = settings.arguments;
      return MaterialPageRoute(builder: (_) => const PageOfShopperOrders());
    case '/AngelOrders':
      return MaterialPageRoute(builder: (_) => const PageOfAngelOrders());
    default:
      return null;
  }
}
