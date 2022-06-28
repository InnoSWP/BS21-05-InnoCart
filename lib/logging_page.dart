import 'package:flutter/material.dart';
import 'backend_functions.dart';
import 'user.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);
  Color mistakeColor = Colors.white;
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String curPass = "";
  String curNick = "";
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 300,
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
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Nickname',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: TextField(
                onChanged: (text) {
                  curNick = text;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Nickname(not telegram alias)',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Password',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 40,
              child: TextField(
                onChanged: (text) {
                  curPass = text;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color(0xffF2F208)),
                  onPressed: () async {
                    if (await dataIsCorrect(curNick, curPass)) {
               //       var user = User(await getDataByNick(curNick));
                      Navigator.of(context)
                          .pushReplacementNamed('/PageOfActiveOrders');
                    } else {
                     setState(() {
                     widget.mistakeColor = Colors.redAccent;
                      });
                    }
                  },
                  child: const Text(
                    'Get into system!',
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
