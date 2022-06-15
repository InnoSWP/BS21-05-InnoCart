import 'package:flutter/material.dart';
import 'backend_functions.dart';
import 'user.dart';
class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);
  Color mistake_color = Colors.white;
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
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
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
              height: 30,
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
                  curNick = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Nickname(not telegram alias)',
                ),
              ),
              height: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Password',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              child: TextField(
                onChanged: (text) {
                  curPass = text;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
              height: 40,
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xffF2F208)),
                  onPressed: () async {
                    if (await dataIsCorrect(curNick, curPass)){
                      var user = User(await getDataByNick(curNick));
                      Navigator.of(context).pushReplacementNamed('/ShopperOrders');
                    }
                    else{
                      setState((){
                        widget.mistake_color = Colors.redAccent;
                      });
                    }
                  },
                  child: Text(
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
