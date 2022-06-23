import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inno_cart/PageOfAngelOrders/pop_up_notify.dart';
import 'pop_up_window_with_ticket.dart';
import '../elevated_button_style.dart';
import '../navigation_bar.dart';
import '../main.dart';
import 'app_bar.dart';

class PageOfAngelOrders extends StatefulWidget {
  const PageOfAngelOrders({Key? key}) : super(key: key);

  @override
  State<PageOfAngelOrders> createState() => PageOfAngelOrdersState();
}

class PageOfAngelOrdersState extends State<PageOfAngelOrders> {
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
  late List<Widget> waitingForAccept;
  late List<Widget> inProgress;
  late List<Widget> completed;

  Tickets(BuildContext context, PageOfAngelOrdersState page) {
    waitingForAccept = setTicket('Cancel Request', context, page);
    inProgress = setTicket('Open Chat', context, page) +
        setTicket('Open Chat', context, page);
    completed = setTicket('Rate Shopper', context, page);
  }

  List<Widget> getTickets() {
    return generateHeader('Waiting for accept') +
        waitingForAccept +
        generateHeader('In progress') +
        inProgress +
        generateHeader('Completed') +
        completed;
  }

  List<Widget> setTicket(
      String text, BuildContext context, PageOfAngelOrdersState page) {
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

    return [];
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