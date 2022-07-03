import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import '../main.dart';

class PageMessenger extends StatefulWidget {
  const PageMessenger({Key? key}) : super(key: key);
  @override
  State<PageMessenger> createState() => PageMessengerState();
}

class PageMessengerState extends State<PageMessenger> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
            onHorizontalDragEnd: ((DragEndDetails details) {
              if (details.primaryVelocity! < 0.0) {
                pageUpdate((selectedPage + 1) % 5, context);
              } else if (details.primaryVelocity! > 0.0) {
                pageUpdate((selectedPage + 4) % 5, context);
              }
            }),
            child: const Scaffold(
              bottomNavigationBar: MainNavigationBar(),
              body: Center(
                child: Text('In development\n:('),
              ),
            )));
  }
}
