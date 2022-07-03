// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inno_cart/LogInPage/logging_page.dart';
import 'package:inno_cart/WelcomePage/hello_screen.dart';
import 'package:inno_cart/RegistrationPage/registration_screen.dart';
// import  'package:inno_cart/PageOfShopperOrders/page_of_shopper_orders.dart';
import 'package:inno_cart/main.dart';
// import 'package:inno_cart/PageOfActiveOrders/page_of_active_orders.dart';
// import 'package:inno_cart/creating_order_screen.dart';
// import 'package:inno_cart/Messenger/page_messenger.dart';

void main() {
  /// Build our app and trigger a frame.
  testWidgets('Hello page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Innocart'), findsOneWidget);
    expect(find.byType(HelloPage), findsOneWidget);
  });

  /// testing possibilities to go to the logging page
  testWidgets('Logging page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Innocart'), findsOneWidget);
    await tester.tap(find.text('log in'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.byType(LogInPage), findsOneWidget);
  });

  /// testing possibilities to go to the registration page
  testWidgets('Registration page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Innocart'), findsOneWidget);
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.byType(RegScreen), findsOneWidget);
  });
}
