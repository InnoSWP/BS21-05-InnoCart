import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'generate_route.dart';
import 'hello_screen.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

class startAnimation extends StatefulWidget {
  const startAnimation({Key? key}) : super(key: key);

  @override
  State<startAnimation> createState() => _startAnimationState();
}

class _startAnimationState extends State<startAnimation> {
  static const List<Color> colors = [Colors.yellowAccent, Colors.pinkAccent];
  late final Timer _timer;

  @override
  _startAnimationState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 700),
            pageBuilder: (_, __, ___) => HelloPage(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Hero(
        tag: 'pochitta',
        child: Container(
          child: Align(
            alignment: Alignment.center,
            child: FadeIn(
              duration: const Duration(milliseconds: 1200),
              child: Text(
                'Welcome',
                style: TextStyle(fontSize: 70, color: Colors.black, decoration: TextDecoration.none),

              ),
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                  stops: [0.2, 1.2])),
        ));
  }
}
