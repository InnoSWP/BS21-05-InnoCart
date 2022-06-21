import 'package:flutter/material.dart';
import '../PageOfActiveOrders/app_bar.dart';
import '../navigation_bar.dart';
import 'set_ticket.dart';

class PageOfActiveOrders extends StatefulWidget {
  const PageOfActiveOrders({Key? key}) : super(key: key);

  @override
  State<PageOfActiveOrders> createState() => PageOfActiveOrdersState();
}

class PageOfActiveOrdersState extends State<PageOfActiveOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(context, this),
            bottomNavigationBar: makeNavigationBar(context, this),
            body: ListView(
              children: Tickets(context).getTickets(),
            ))); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class Tickets {
  List<Widget> waitingForAccept = [];

  Tickets(BuildContext context) {
    waitingForAccept =
        setTicket(context) + setTicket(context) + setTicket(context);
  }

  List<Widget> getTickets() {
    return waitingForAccept;
  }
}
