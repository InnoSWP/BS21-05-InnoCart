import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class StartAnimation extends StatefulWidget {
  const StartAnimation({Key? key}) : super(key: key);

  @override
  State<StartAnimation> createState() => _StartAnimationState();
}

class _StartAnimationState extends State<StartAnimation> {
  static const List<Color> colors = [Colors.yellowAccent, Colors.pinkAccent];

  @override
  _StartAnimationState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.of(context).pushReplacementNamed('/');
        /*
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (_, __, ___) => const HelloPage(),
          ),
        );*/
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: 'pochitta',
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                  stops: [0.2, 1.2])),
          child: const Align(
            alignment: Alignment.center,
            child: FadeIn(
              duration: Duration(milliseconds: 1200),
              child: Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 70,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ));
  }
}
