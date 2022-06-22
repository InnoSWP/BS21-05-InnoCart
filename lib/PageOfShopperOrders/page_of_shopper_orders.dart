import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'completed_popup_window.dart';
import 'waiting_popup_ticket.dart';
import '../elevated_button_style.dart';
import 'in_progress_popup_window.dart';
import '../navigation_bar.dart';
import '../main.dart';
import 'app_bar.dart';

class PageOfShopperOrders extends StatefulWidget {
  const PageOfShopperOrders({Key? key}) : super(key: key);

  @override
  State<PageOfShopperOrders> createState() => PageOfShopperOrdersState();
}

class PageOfShopperOrdersState extends State<PageOfShopperOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(context),
            bottomNavigationBar: makeNavigationBar(context, this),
            body: ListView(
              children: Tickets(context, this).getTickets(),
            ))); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class Tickets {
  late PageOfShopperOrdersState page;
  late List<Widget> waitingForAccept;
  late List<Widget> inProgress;
  late List<Widget> completed;

  Tickets(BuildContext context, PageOfShopperOrdersState page1) {
    page = page1;
    waitingForAccept = setTicket('See requests', context);
    inProgress =
        setTicket('Open Chat', context) + setTicket('Open Chat', context);
    completed = setTicket('Rate Angel', context);
  }

  List<Widget> getTickets() {
    return generateHeader('Waiting for accept') +
        waitingForAccept +
        generateHeader('In progress') +
        inProgress +
        generateHeader('Completed') +
        completed;
  }

  List<Widget> setTicket(String text, BuildContext context) {
    return [
      GestureDetector(
        onTap: () {
          if (text == 'See requests') {
            waitingPopUpTicket(context);
          } else if (text == 'Open Chat') {
            inProgressPopUpTicket(context);
          } else {
            completedPopUpTicket(context);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: bottomPadding),
          width: 345,
          height: 208,
          color: Colors.white,
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
                    margin:
                        const EdgeInsets.only(top: 12, left: 12, bottom: 10),
                    child: Image.asset(
                      'assets/images/pizza.jpg',
                      fit: BoxFit.fill,
                    ),
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
                  onPressed: () {
                    if (text == 'Open Chat') {
                      page.setState(() {
                        selectedPage = 3;
                        Navigator.of(context)
                            .pushReplacementNamed('/Messenger');
                      });
                    }
                  },
                  style: RoundedWhite,
                  child: SizedBox(
                    width: 150,
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          text,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 14,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
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
