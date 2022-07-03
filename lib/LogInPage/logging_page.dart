import 'dart:ffi';

import 'package:flutter/material.dart';
import '../backend_functions.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  Color mistakeColor = Colors.white;

  String curPass = "";
  String curNick = "";
  int? groupValue;
  int? shouldSave;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
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
                    backgroundColor: mistakeColor,
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
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xffF2F208)),
                    onPressed: () async {
                      if (await dataIsCorrect(curNick, curPass)) {
                        if (shouldSave == 1) {
                          Map<String, dynamic> data = {
                            'nickname': curNick,
                            'password_hash': getHash(curPass),
                          };
                          final directory =
                              await getApplicationDocumentsDirectory();
                          File file = File('${directory.path}/data.json');
                          if (await file.exists() == false) {
                            await file.create();
                          }
                          await file.delete();
                          await file.create();
                          await file.writeAsString(jsonEncode(data));
                        }
                        Navigator.of(context)
                            .pushReplacementNamed('/PageOfActiveOrders');
                      } else {
                        setState(() {
                          mistakeColor = Colors.redAccent;
                        });
                      }
                    },
                    child: const Text(
                      'Get into system!',
                      style: TextStyle(color: Color(0xff000000)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(children: [
                Radio<int>(
                    activeColor: const Color(0xff000000),
                    toggleable: true,
                    value: 1,
                    groupValue: groupValue,
                    onChanged: (int? value) {
                      setState(() {
                        groupValue = value;
                        shouldSave = value;
                      });
                    }),
                const Text(
                  'Remember me',
                  style: TextStyle(fontSize: 20),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
