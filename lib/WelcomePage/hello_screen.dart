import 'package:flutter/material.dart';

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
            child: Center( child: Stack(children: [
              Padding(
                  padding:EdgeInsets.only(left: 100)
                  ,child: Hero(
                    tag: 'pochitta',
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: colors,
                              stops: [0.2, 1.2])),
                    ),
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 0, top: 45),
                child: Text(
                  'Innocart',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ]),
          ),),
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
                    Navigator.of(context)
                        .pushReplacementNamed('/RegistrationPage');
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
                    Navigator.of(context).pushReplacementNamed('/LogInPage');
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