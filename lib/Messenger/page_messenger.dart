import 'package:flutter/material.dart';
import 'package:inno_cart/navigation_bar.dart';

class PageMessenger extends StatefulWidget {
  const PageMessenger({Key? key}) : super(key: key);
  @override
  State<PageMessenger> createState() => PageMessengerState();
}

class PageMessengerState extends State<PageMessenger> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: makeNavigationBar(context, this),
      body: const Center(
        child: Text('In development\n:('),
      ),
    ));
  }
}
