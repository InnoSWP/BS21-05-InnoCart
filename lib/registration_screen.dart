import 'package:flutter/material.dart';

class regScreen extends StatelessWidget {
  regScreen({Key? key}) : super(key: key);
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
            ),
            Text(
              'Name',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: TextField(
                onChanged: (text) {
                  print('First text field: $text');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
              height: 40,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: TextField(
                onChanged: (text) {
                  print('First text field: $text');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Surname',
                ),
              ),
              height: 40,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Nickname',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: TextField(
                onChanged: (text) {
                  print('First text field: $text');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '@yourNickname',
                ),
              ),
              height: 40,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Contact Information',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: TextField(
                onChanged: (text) {
                  print('First text field: $text');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'E-mail',
                ),
              ),
              height: 40,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: TextField(
                onChanged: (text) {
                  print('First text field: $text');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Telegram alias',
                ),
              ),
              height: 40,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: TextField(
                onChanged: (text) {
                  print('First text field: $text');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Telephone number',
                ),
              ),
              height: 40,
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              child: TextField(
                onChanged: (text) {
                  print('First text field: $text');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter password',
                ),
              ),
              height: 40,
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xffF2F208)),
                  onPressed: () {},
                  child: Text(
                    'Create profile',
                    style: TextStyle(color: Color(0xff000000)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
