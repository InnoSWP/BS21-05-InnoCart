import 'package:flutter/material.dart';
import 'generate_route.dart';

void main() => runApp(const MyApp());

int selectedPage = 0;
const double bottomPadding = 29;

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
