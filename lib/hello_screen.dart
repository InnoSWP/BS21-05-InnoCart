import 'package:flutter/material.dart';

class helloPage extends StatelessWidget {
  const helloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SizedBox(
            height: 275,
          ),
          Text('Innocart', style: TextStyle(fontSize: 50),),
          SizedBox(
            height: 50,
          ),
          Text('Welcome!', style: TextStyle(fontSize: 30),),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 300,
            height: 43,
          child:ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Color(0xffF2F208)),
              child: Text(
                'Create profile',
                style: TextStyle(color: Color(0xff000000)),
              )))
        ],
      ),
    );
  }
}
