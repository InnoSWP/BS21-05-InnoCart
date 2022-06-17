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
              child: TextField(
                onChanged: (text) {
                  raw_data['name'] = text;
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
                  raw_data['surname'] = text;
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
                  raw_data['allias'] = text;
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
                  raw_data['e-mail'] = text;
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
                  raw_data['telegram'] = text;
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
                  raw_data['phone_number'] = text;
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
                  raw_data['password'] = text;
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
                  onPressed: () async {
                    print(raw_data.toString());
                    if (await nickExists(raw_data['allias'])) {
                      setState(() {
                        widget.mistake_color = Colors.redAccent;
                      });
                    } else {
                      raw_data['password'] =
                          await getHash(raw_data['password']);
                      ;
                      raw_data['user_id'] = await getId(raw_data['allias']);
                      var user = User(raw_data);
                      await addUser(user);
                      Navigator.of(context)
                          .pushReplacementNamed('/PageOfActiveOrders');
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
