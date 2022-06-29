import 'package:flutter/material.dart';
import '../navigation_bar.dart';
import 'package:inno_cart/main.dart';

class PageMessenger extends StatefulWidget {
  const PageMessenger({Key? key}) : super(key: key);
  @override
  State<PageMessenger> createState() => PageMessengerState();
}

class PageMessengerState extends State<PageMessenger> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector( child: Scaffold(
      bottomNavigationBar: makeNavigationBar(context, this),
      body: const Center(
        child: Text('In development\n:('),
      ),
    ), onHorizontalDragEnd: ((DragEndDetails details) {
          if (details.primaryVelocity! > 0.0) {
            pageUpdate((selectedPage + 1) % 5, context);
          } else if (details.primaryVelocity! < 0.0){
            pageUpdate((selectedPage + 4) % 5, context);
          }
        })));
  }
}
