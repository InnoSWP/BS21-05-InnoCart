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
import 'start_screen.dart';

Route? generateRoute(RouteSettings settings) {
  // final data = settings.arguments;
  switch (settings.name) {
    case '/start':
      return PageTransition(
          child: const StartAnimation(), type: PageTransitionType.fade);
    case '/':
      return PageTransition(
          child: const HelloPage(), type: PageTransitionType.fade);
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
      return PageTransition(child: RegScreen(), type: PageTransitionType.fade);
    case '/LogInPage':
      return PageTransition(child: LogInPage(), type: PageTransitionType.fade);
    case '/CreatingOrderScreen':
      return PageTransition(
          child: const OrderFactoryPage(), type: PageTransitionType.fade);
    case '/ProfileScreen':
      return PageTransition(
          child: ProfilePage(), type: PageTransitionType.fade);
    case '/ProfileChangeScreen':
      return MaterialPageRoute(builder: (_) => const ProfileChangeScreen());
    case '/Messenger':
      return PageTransition(
          child: const PageMessenger(), type: PageTransitionType.fade);
    default:
      return null;
  }
}
