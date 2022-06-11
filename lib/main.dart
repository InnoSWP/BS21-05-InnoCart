import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'hello_screen.dart';
import 'profile_screen.dart';
import 'creating_order_screen.dart';
import 'profile_change_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const baseScreen(),
    );
  }
}

class baseScreen extends StatefulWidget {
  const baseScreen({Key? key}) : super(key: key);

  @override
  State<baseScreen> createState() => _baseScreenState();
}

class _baseScreenState extends State<baseScreen> {
  @override
  Widget build(BuildContext context) {
    return ProfileChangePage();
  }
}
