import 'package:flutter/material.dart';
import 'Messenger/page_messenger.dart';
import 'package:page_transition/page_transition.dart';
import 'hello_screen.dart';
import 'profile_change_screen.dart';
import 'profile_screen.dart';
import 'registration_screen.dart';
import 'PageOfActiveOrders/page_of_active_orders.dart';
import 'PageOfAngelOrders/page_of_angel_orders.dart';
import 'PageOfShopperOrders/page_of_shopper_orders.dart';
import 'logging_page.dart';
import 'creating_order_screen.dart';

Route? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final data = settings.arguments;
      return MaterialPageRoute(builder: (_) => const helloPage());
    case '/PageOfActiveOrders':
      return PageTransition(
          child: const PageOfActiveOrders(), type: PageTransitionType.fade);
    case '/AngelOrders':
      return PageTransition(
          child: const PageOfAngelOrders(), type: PageTransitionType.fade);
    case '/ShopperOrders':
      return PageTransition(
          child: const PageOfShopperOrders(), type: PageTransitionType.fade);
    case '/RegistrationPage':
      return MaterialPageRoute(builder: (_) => regScreen());
    case '/LogInPage':
      return MaterialPageRoute(builder: (_) => LogInPage());
    case '/CreatingOrderScreen':
      return PageTransition(
          child: const OrderFactoryPage(), type: PageTransitionType.fade);
    case '/ProfileScreen':
      return PageTransition(
          child: const ProfilePage(), type: PageTransitionType.fade);
    case '/ProfileChangeScreen':
      return MaterialPageRoute(builder: (_) => ProfileChangeScreen());
    case '/Messenger':
      return PageTransition(
          child: const PageMessenger(), type: PageTransitionType.fade);
    default:
      return null;
  }
}