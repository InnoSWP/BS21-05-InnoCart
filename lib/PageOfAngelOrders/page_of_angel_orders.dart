import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pop_up_window_with_ticket.dart';
import '../elevated_button_style.dart';
import '../navigation_bar.dart';
import '../main.dart';
import 'app_bar.dart';

class PageOfAngelOrders extends StatefulWidget {
  const PageOfAngelOrders({Key? key}) : super(key: key);

  @override
  State<PageOfAngelOrders> createState() => _PageOfAngelOrdersState();
}

class _PageOfAngelOrdersState extends State<PageOfAngelOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(context),
            bottomNavigationBar: makeNavigationBar(context, this),
            body: ListView(
              children: Tickets(context).getTickets(),
            ))); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class Tickets {
  late List<Widget> waitingForAccept;
  late List<Widget> inProgress;
  late List<Widget> completed;

  Tickets(BuildContext context) {
    waitingForAccept = setTicket('Cancel Request', context);
    inProgress =
        setTicket('Open Chat', context) + setTicket('Open Chat', context);
    completed = setTicket('Rate Shopper', context);
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
    String buttonText = text;
    String profilePicture = 'assets/images/man1.png';
    String orderImage = 'assets/images/rolls.jpg';
    String orderName = 'Rolls';
    String orderWeight = '1 kg';
    String orderDistance = '125 m';
    String orderTime = '15:00';
    String orderDate = '03.06.2022';
    String orderPrice = '300';
    String orderInfo = 'I want two DoDo peperoni pizzas, thank you!';
    String orderAngel = 'Amr. T.';

    return [
      GestureDetector(
        onTap: () => popUpTicket(context),
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
                      orderImage,
                      fit: BoxFit.fill,
                    ),
                  ),

                  //TICKET INFO

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: Text(
                            orderName,
                            style: const TextStyle(fontSize: 20),
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
                              child: Text(orderWeight)),
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
                              child: Text(orderDistance)),
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
                              child: Text(orderTime)),
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
                          Text(orderPrice),
                          SvgPicture.asset('assets/icons/Currency.svg'),
                        ],
                      )),
                ],
              ),
              //Button

              ElevatedButton(
                  onPressed: () {},
                  style: RoundedWhite,
                  child: SizedBox(
                    width: 150,
                    height: 32,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          buttonText,
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
