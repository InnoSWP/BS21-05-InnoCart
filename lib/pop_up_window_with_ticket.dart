import 'package:flutter/material.dart';
import 'set_ticket.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main.dart';

Future popUpTicket(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: SizedBox(
            height: 400,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(bottom: bottomPadding),
                width: 345,
                height: 208,
                color: const Color(gray),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //PICTURE
                        Container(
                          width: 130,
                          height: 130,
                          color: Colors.blueGrey,
                          margin: const EdgeInsets.only(
                              top: 12, left: 12, bottom: 10),
                        ),

                        //TICKET INFO

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 12),
                                child: const Text(
                                  'Pizza',
                                  style: TextStyle(fontSize: 20),
                                )),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/Bag_alt_light.svg',
                                  color: Colors.black,
                                  width: 24,
                                  height: 24,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text('2 kg')),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/Pin_alt_light.svg',
                                  color: Colors.black,
                                  width: 24,
                                  height: 24,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text('124 m')),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/Time_light.svg',
                                  color: Colors.black,
                                  width: 24,
                                  height: 24,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text('14:00')),
                              ],
                            ),
                          ],
                        ),

                        Container(
                            margin: const EdgeInsets.all(12),
                            color: Colors.yellowAccent,
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              children: [
                                const Text('100'),
                                SvgPicture.asset('assets/icons/Currency.svg'),
                              ],
                            )),
                      ],
                    ),
                    //Button
                  ],
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: ListView(
                  children: const [
                    Text('I want two DoDo peperoni pizzas, thank you!'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const CircleAvatar(
                    radius: (20),
                    backgroundImage: AssetImage('assets/images/man.jpg'),
                  ),
                  const Text('Amr. T.'),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Center(
                          child: Text(
                        'Send request',
                        style: TextStyle(fontSize: 14),
                      ))),
                ],
              ),
            ]),
          ));
    },
  );
}
