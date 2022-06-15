import 'package:flutter/material.dart';
import 'GenerateRoute.dart';
import 'registration_screen.dart';

void main() => runApp(const MyApp());

int selectedPage = 0;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      initialRoute: '/',
      onGenerateRoute: generateRoute,
    );
  }
}
