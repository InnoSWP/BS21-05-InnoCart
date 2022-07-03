import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inno_cart/UI/PopUpWindows/rate_window.dart';
import '../UI/Blocks/TicketBlock.dart';
import '../ticket.dart';
import 'WindowLowBar/completed.dart';
import 'WindowLowBar/in_progress.dart';
import 'see_requests_window.dart';
import '../backend_functions.dart';
import 'WindowLowBar/waiting.dart';
import '../UI/Buttons/elevated_button_style.dart';
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
        child: GestureDetector(
            onHorizontalDragEnd: ((DragEndDetails details) {
              if (details.primaryVelocity! < 0.0) {
                pageUpdate((selectedPage + 1) % 5, context);
              } else if (details.primaryVelocity! > 0.0) {
                pageUpdate((selectedPage + 4) % 5, context);
              }
            }),
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: const ThisAppBar(),
                bottomNavigationBar: const MainNavigationBar(),
                body: FutureBuilder<List<Widget>>(
                    future: getTickets(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView(children: snapshot.data!);
                      } else {
                        return const Text('Waiting for data');
                      }
                    })))); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Future<List<Widget>> getTickets() async {
    Map<String, dynamic> waitingForAcceptHistoryTickets =
        await getTicketHistory(0, 0);
    Map<String, dynamic> inProgressHistoryTickets =
        await getTicketHistory(1, 0);
    Map<String, dynamic> completedHistoryTickets = await getTicketHistory(2, 0);
    List<Widget> listToReturn = [];
    listToReturn.add(generateHeader('Waiting for accept'));
    for (Map<String, dynamic> tokenNote
        in waitingForAcceptHistoryTickets['tickets']) {
      listToReturn.add(createTicketFromData(tokenNote, this));
    }

    listToReturn.add(generateHeader('In progress'));
    for (Map<String, dynamic> tokenNote
        in inProgressHistoryTickets['tickets']) {
      listToReturn.add(createTicketFromData(tokenNote, this));
    }
    listToReturn.add(generateHeader('Completed'));
    for (Map<String, dynamic> tokenNote in completedHistoryTickets['tickets']) {
      listToReturn.add(createTicketFromData(tokenNote, this));
    }
    return listToReturn;
  }

  SetTicket createTicketFromData(
      Map<String, dynamic> data, PageOfShopperOrdersState page) {
    return SetTicket(Ticket(data), page);
  }

  Widget generateHeader(String text) {
    return Container(
        width: 161,
        height: 22,
        margin: const EdgeInsets.only(left: 29, bottom: bottomPadding),
        child: Text(
          text,
          style: const TextStyle(fontSize: 20),
        ));
  }
}

class SetTicket extends StatelessWidget {
  final Ticket ticket;
  late final String buttonText;
  final PageOfShopperOrdersState page;

  SetTicket(this.ticket, this.page, {Key? key}) : super(key: key) {
    if (ticket.status == TicketType.waitingForAccept) {
      buttonText = 'See requests';
    } else if (ticket.status == TicketType.inProgress) {
      buttonText = 'Cancel Order';
    } else if (ticket.status == TicketType.completed) {
      buttonText = 'Rate Angel';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget lowBar = ElevatedButton(
        onPressed: () async {
          if (ticket.status == TicketType.waitingForAccept) {
            seeRequestWindow(context, ticket.ticketId, page);
          } else if (ticket.status == TicketType.inProgress) {
            if (kDebugMode) {
              print("BUTTON OF COMPLETING ORDER HAS BEEN PRESSED");
            }
            bool result = await completeOrder(ticket.ticketId);

            if (result) {
              page.setState(() {});
            }
          } else if (ticket.status == TicketType.completed) {
            rateWindow(context, ticket, UserType.shopper);
            page.setState(() => {});
          }
        },
        style: roundedWhite,
        child: SizedBox(
          width: 150,
          height: 32,
          child: TextAndArrowButtonChild(buttonText: buttonText),
        ));

    late final Widget windowLowBar;

    if (ticket.status == TicketType.waitingForAccept) {
      windowLowBar = waiting(context, ticket, 'Cancel Order', page);
    } else if (ticket.status == TicketType.inProgress) {
      windowLowBar = inProgress(context, ticket, buttonText, page);
    } else {
      windowLowBar = completed(context, ticket, buttonText, page);
    }

    return TicketBlock(
      ticket: ticket,
      lowBar: lowBar,
      windowLowBar: windowLowBar,
    );
  }
}
