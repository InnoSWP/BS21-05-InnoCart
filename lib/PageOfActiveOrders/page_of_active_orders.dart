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
            body: FutureBuilder<List<Widget>>(
              future: Tickets(context).getTickets(),
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return ListView(
                    children: snapshot.data!
                  );
                }
                else{
                  return const Text("waiting for data");
                }
              }
            ))); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class Tickets {
  List<Widget> waitingForAccept = [];

  Tickets(BuildContext context) {
    waitingForAccept =
        Ticket(context) + Ticket(context) + Ticket(context);
  }

  Future<List<Widget>> getTickets() async {
    return waitingForAccept;
  }
}
