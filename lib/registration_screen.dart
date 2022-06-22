// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'backend_functions.dart';
import 'user.dart';

class regScreen extends StatefulWidget {
  regScreen({Key? key}) : super(key: key);
  Color mistake_color = Colors.white;

  @override
  State<regScreen> createState() => _regScreenState();
}

class _regScreenState extends State<regScreen> {
  @override
  Map<String, dynamic> raw_data = getEmptyMap();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
            ),
            Center(
              child: Text(
                'password/nickname are incorrect!',
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: widget.mistake_color,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Name',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                onChanged: (text) {
                  raw_data['name'] = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                onChanged: (text) {
                  raw_data['surname'] = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Surname',
                ),
              ),
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
              height: 40,
              child: TextField(
                onChanged: (text) {
                  raw_data['nickname'] = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '@yourNickname',
                ),
              ),
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
              height: 40,
              child: TextField(
                onChanged: (text) {
                  raw_data['email'] = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'E-mail',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                onChanged: (text) {
                  raw_data['telegram'] = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Telegram alias',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                onChanged: (text) {
                  raw_data['phone_number'] = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Telephone number',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                onChanged: (text) {
                  raw_data['password'] = text;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter password',
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xffF2F208)),
                  onPressed: () async {
                    // print(raw_data.toString());
                    raw_data['password_hash'] = getHash(raw_data['password']);
                    currentUser = User(raw_data);
                    print("currentUser.passwordHash = ${currentUser.passwordHash}");
                    // print("currentUser has been created");
                    if (await contactDataOccupied(currentUser)) {
                      setState(() {
                        widget.mistake_color = Colors.redAccent;
                      });
                    }
                    else {
                      bool registerResult = await addUser(currentUser);
                      if (registerResult) {
                        Navigator.of(context)
                            .pushReplacementNamed('/PageOfActiveOrders');
                      }
                      else{
                        setState(() {
                          widget.mistake_color = Colors.redAccent;
                        });
                      }
                    }
                  },
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
