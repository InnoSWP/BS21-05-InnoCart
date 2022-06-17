import 'package:flutter/material.dart';

class OrderFactoryPage extends StatelessWidget {
  const OrderFactoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            SizedBox(
                child: TextField(
                  onChanged: (text) {
                    print('First text field: $text');
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      borderSide:
                      const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(7.0)),
                    ),
                    hintText: 'Name',
                  ),
                ),
                height: 30),
            SizedBox(
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
                    margin: EdgeInsets.only(top: 12, left: 12, bottom: 10),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(children: [
                    SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: 150,
                      height: 30,
                      child: TextField(
                        onChanged: (text) {
                          print('First text field: $text');
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(7.0)),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(7.0)),
                          ),
                          hintText: 'Enter weight',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 150,
                      height: 30,
                      child: TextField(
                        onChanged: (text) {
                          print('First text field: $text');
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(7.0)),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(7.0)),
                          ),
                          hintText: 'Add location',
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('Additional info'),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              child: TextField(
                onChanged: (text) {
                  print('First text field: $text');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 30,
              child: TextField(
                onChanged: (text) {
                  print('First text field: $text');
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(7.0)),
                  ),
                  hintText: 'Type',
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reward'),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: TextField(
                      onChanged: (text) {
                        print('First text field: $text');
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(7.0)),
                        ),
                        hintText: 'Type',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Deadline'),
                  SizedBox(
                    width: 100,
                    height: 30,
                    child: TextField(
                      onChanged: (text) {
                        print('First text field: $text');
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(7.0)),
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
                        print('First text field: $text');
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius:
                          const BorderRadius.all(Radius.circular(7.0)),
                        ),
                        hintText: 'Set time',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Center(
              child: SizedBox(
                height: 60,
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Color(0xffF2F208)),
                  onPressed: () {},
                  child: Text(
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