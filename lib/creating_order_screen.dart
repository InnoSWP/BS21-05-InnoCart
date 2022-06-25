import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inno_cart/backend_functions.dart';
import 'navigation_bar.dart';

class OrderFactoryPage extends StatefulWidget {
  const OrderFactoryPage({Key? key}) : super(key: key);

  @override
  State<OrderFactoryPage> createState() => _OrderFactoryPageState();
}

class _OrderFactoryPageState extends State<OrderFactoryPage> {
  String title = "";
  String description = "";
  String type = "";
  double reward = 0.0;
  double weight = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: makeNavigationBar(context, this),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            SizedBox(
                height: 30,
                child: TextField(
                  onChanged: (text) {
                    title = text;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      borderSide:
                          BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black, width: 2.0),
                      borderRadius:
                          BorderRadius.all(Radius.circular(7.0)),
                    ),
                    hintText: 'Name',
                  ),
                )),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    color: Colors.blueGrey,
                    margin: const EdgeInsets.only(top: 12, left: 12, bottom: 10),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(children: [
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: 150,
                      height: 30,
                      child: TextField(
                        onChanged: (text) {
                         try{
                           weight = double.parse(text);
                         }
                         on Exception{
                           weight = 0.0;
                         }
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                            borderSide: BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                          ),
                          hintText: 'Enter weight',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 150,
                      height: 30,
                      child: TextField(
                        onChanged: (text) {
                          // WHY THIS FIELD IS TEXT?????? 8 )
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                            borderSide: BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                          ),
                          hintText: 'Add location',
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('Additional info'),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              child: TextField(
                onChanged: (text) {
                  description = text;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    borderSide:
                        BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 30,
              child: TextField(
                onChanged: (text) {
                  type = text;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    borderSide:
                        BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  hintText: 'Type',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Reward'),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: TextField(
                      onChanged: (text) {
                        try{
                          reward = double.parse(text);
                        }
                        on Exception{
                          reward = 0;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(7.0)),
                        ),
                        hintText: 'In rubles',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Deadline'),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: TextField(
                      onChanged: (text) {

                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(7.0)),
                        ),
                        hintText: 'Set date',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: TextField(
                      onChanged: (text) {
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(7.0)),
                        ),
                        hintText: 'Set time',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Center(
              child: SizedBox(
                height: 60,
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: const Color(0xffF2F208)),
                  onPressed: () async {
                    if (kDebugMode) {
                      print("Button had been pressed");
                    }
                    await registerNewTicket({
                      "title": title,
                      "description": description,
                      "weight": weight.toString().replaceAll('.', ','),
                      "product_type": type,
                      "reward": reward.toString().replaceAll('.', ',')
                    });
                    Navigator.of(context)
                        .pushReplacementNamed('/PageOfActiveOrders');
                  },
                  child: const Text(
                    'Push Order',
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
