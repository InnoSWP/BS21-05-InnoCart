// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'backend_functions.dart';
import 'user.dart';

class RegScreen extends StatefulWidget {
  RegScreen({Key? key}) : super(key: key);
  Color mistakeColor = Colors.white;

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  Map<String, dynamic> rawData = getEmptyMap();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView( child : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                'password/nickname are incorrect!',
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: widget.mistakeColor,
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
                  rawData['name'] = text;
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
                  rawData['surname'] = text;
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
                  rawData['nickname'] = text;
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
                  rawData['email'] = text;
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
                  rawData['telegram'] = text;
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
                  rawData['phone_number'] = text;
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
                  rawData['password'] = text;
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
                    rawData['password_hash'] = getHash(rawData['password']);
                    currentUser = User(rawData);
                    if (kDebugMode) {
                      print("currentUser.passwordHash = ${currentUser.passwordHash}");
                    }
                    // print("currentUser has been created");
                    if (await contactDataOccupied(currentUser)) {
                      setState(() {
                        widget.mistakeColor = Colors.redAccent;
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
                          widget.mistakeColor = Colors.redAccent;
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
        ),),
      ),
    );
  }
}
