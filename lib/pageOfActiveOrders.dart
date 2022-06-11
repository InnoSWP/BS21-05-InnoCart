import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageOfActiveOrders extends StatefulWidget {
  const PageOfActiveOrders({Key? key}) : super(key: key);

  @override
  State<PageOfActiveOrders> createState() => _PageOfActiveOrdersState();
}

class _PageOfActiveOrdersState extends State<PageOfActiveOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.yellowAccent),
                child: const Text('Move to Angel page',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
              ),
            ),
            /*bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.list))
                ]),*/
            body: ListView(
              children: Tickets().getTickets(),
            ))); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

const int gray = 0xe5e5e5e5;
const double bottomPadding = 29;

class Tickets {
  late List<Widget> waitingForAccept;
  late List<Widget> inProgress;
  late List<Widget> completed;

  Tickets() {
    waitingForAccept = setTicket('See requests');
    inProgress = setTicket('Open Chat') + setTicket('Open Chat');
    completed = setTicket('Rate Angel');
  }

  List<Widget> getTickets() {
    return generateHeader('Waiting for accept') +
        waitingForAccept +
        generateHeader('In progress') +
        inProgress +
        generateHeader('Completed') +
        completed;
  }

  List<Widget> setTicket(String text) {
    return [
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
                  margin: const EdgeInsets.only(top: 12, left: 12, bottom: 10),
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

            ElevatedButton(
                onPressed: () {},
                child: Container(
                    width: 150,
                    height: 32,
                    child: Center(
                        child: Text(
                      text,
                      style: const TextStyle(fontSize: 14),
                    )))),
          ],
        ),
      )
    ];
  }

  List<Widget> generateHeader(String text) {
    return [
      Container(
          width: 161,
          height: 22,
          margin: const EdgeInsets.only(left: 29, bottom: bottomPadding),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          )),
    ];
  }
}
