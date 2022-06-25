import 'package:flutter/material.dart';

class HelloPage extends StatelessWidget {
  const HelloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const SizedBox(
            height: 275,
          ),
          const Text(
            'Innocart',
            style: TextStyle(fontSize: 50),
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
                    Navigator.of(context)
                        .pushReplacementNamed('/RegistrationPage');
                  },
                  style: ElevatedButton.styleFrom(primary: const Color(0xffF2F208)),
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
                  style: ElevatedButton.styleFrom(primary: const Color(0xffF2F208)),
                  child: const Text(
                    'log in',
                    style: TextStyle(color: Color(0xff000000)),
                  )))
        ],
      ),
    );
  }
}
