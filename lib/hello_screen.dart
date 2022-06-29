import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';
import 'package:animations/animations.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({Key? key}) : super(key: key);
  static const List<Color> colors = [Colors.yellowAccent, Colors.pinkAccent];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const SizedBox(
            height: 275,
          ),
          Container(
            width: double.infinity,
            height: 150,
            child: Stack(children: [
              Align(
                alignment: Alignment(0.5, 0),
                child: Hero(tag:'pochitta', child:Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: colors,
                                stops: [0.2, 1.2])),
                      ),)
                  ),
              const Align(
                alignment: Alignment(-0.2, 0.0),
                child: Text(
                  'Innocart',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Welcome!',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              width: 300,
              height: 43,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/RegistrationPage');
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffF2F208)),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Color(0xff000000)),
                  ))),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              width: 300,
              height: 43,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/LogInPage');
                  },
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xffF2F208)),
                  child: const Text(
                    'log in',
                    style: TextStyle(color: Color(0xff000000)),
                  )))
        ],
      ),
    );
  }
}
