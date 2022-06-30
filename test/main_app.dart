// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:inno_cart/logging_page.dart';
// import 'package:inno_cart/hello_screen.dart';
import 'package:inno_cart/ProfilePages/profile_screen.dart';
// import 'package:inno_cart/registration_screen.dart';
import 'package:inno_cart/PageOfShopperOrders/page_of_shopper_orders.dart';
// import 'package:inno_cart/main.dart';
import 'package:inno_cart/PageOfActiveOrders/page_of_active_orders.dart';
import 'package:inno_cart/CreatingOrderPage/creating_order_screen.dart';
import 'package:inno_cart/Messenger/page_messenger.dart';
// import 'package:inno_cart/profile_change_screen.dart';
// import 'package:inno_cart/profile_change_screen.dart';

void main() {
  /// finding problems of the following page:
  testWidgets('PageOfActiveOrders', (WidgetTester tester) async {
    await tester.pumpWidget(const PageOfActiveOrders());
    expect(find.byType(PageOfActiveOrders), findsOneWidget);
  });

  /// finding problems of the following page:
  testWidgets('PageOfShopperOrders', (WidgetTester tester) async {
    await tester.pumpWidget(const PageOfShopperOrders());
    expect(find.byType(PageOfShopperOrders), findsOneWidget);
  });

  /// finding problems of the following page:
  testWidgets('Create', (WidgetTester tester) async {
    await tester.pumpWidget(const OrderFactoryPage());
    expect(find.byType(OrderFactoryPage), findsOneWidget);
  });

  /// finding problems of the following page:
  testWidgets('Create order', (WidgetTester tester) async {
    await tester.pumpWidget(const OrderFactoryPage());
    expect(find.byType(OrderFactoryPage), findsOneWidget);
  });

  /// finding problems of the following page:
  testWidgets('Messages', (WidgetTester tester) async {
    await tester.pumpWidget(const PageMessenger());
    expect(find.byType(PageMessenger), findsOneWidget);
  });

  testWidgets('Profile', (WidgetTester tester) async {
    await tester.pumpWidget(ProfilePage());
    expect(find.byType(ProfilePage), findsOneWidget);
  });
}
