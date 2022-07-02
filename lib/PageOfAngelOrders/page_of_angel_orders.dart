import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inno_cart/ticket.dart';
import 'pop_up_notify.dart';
import '../backend_functions.dart';
import 'completed_popup_window.dart';
import 'in_progress_popup_window.dart';
import 'waiting_popup_ticket.dart';
import '../UI/Buttons/elevated_button_style.dart';
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
                    future: Tickets(context, this).getTickets(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView(children: snapshot.data!);
                      } else {
                        return const Text('Waiting for data');
                      }
                    })))); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class Tickets {
  late PageOfAngelOrdersState page;
  List<Widget> listToReturn = [];
  Tickets(BuildContext context, this.page);

  Future<List<Widget>> getTickets() async {
    listToReturn.clear();

    Map<String, dynamic> waitingForAcceptHistoryTickets =
        await getOfferedTickets();
    Map<String, dynamic> inProgressHistoryTickets =
        await getTicketHistory(1, 1);
    Map<String, dynamic> completedHistoryTickets = await getTicketHistory(2, 1);

    listToReturn.add(generateHeader('Waiting for accept'));

    for (Map<String, dynamic> tokenNote
        in waitingForAcceptHistoryTickets['tickets']) {
      listToReturn.add(createTicketFromData(tokenNote));
    }

    listToReturn.add(generateHeader('In progress'));

    for (Map<String, dynamic> tokenNote
        in inProgressHistoryTickets['tickets']) {
      listToReturn.add(createTicketFromData(tokenNote));
    }

    listToReturn.add(generateHeader('Completed'));

    for (Map<String, dynamic> tokenNote in completedHistoryTickets['tickets']) {
      listToReturn.add(createTicketFromData(tokenNote));
    }
    return listToReturn;
  }

  TicketTMP createTicketFromData(Map<String, dynamic> data) {
    int type = 0;
    String buttonText = '';

    if (data['status'] == 0) {
      type = 0;
      buttonText = "Cancel request";
    } else if (data['status'] == 1) {
      type = 1;
      buttonText = "Cancel (Rewrite)";
    } else if (data['status'] == 2) {
      type = 3;
      buttonText = "Rate Shopper";
    }
    return TicketTMP(
      type,
      data['ticket_id'],
      data['shopper_id'],
      data['title'],
      data['weight'],
      data['reward'],
      data['description'],
      buttonText,
      data['shopper_info']['surname'],
      data['shopper_info']['name'],
      page,
    );
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

class TicketTMP extends StatelessWidget {
  int ticketId = 0;
  int shopperId = 0;
  int angelId = 0;
  final int type;

  String orderImage = 'assets/images/pizza.jpg';
  String orderName = "";
  double orderWeight = 0;
  String userName = 'kek';
  String userSurname = 'kek';
  final double orderDistance = 100; // OVERRIDE IN MVP V2
  final String orderTime = "14:00"; // OVERRIDE IN MVP V2
  double orderPrice = 0;
  String buttonText = "";
  late PageOfAngelOrdersState page;
  String orderDescription = "";
  String orderDate = "23.07.2022";

  TicketTMP(
      this.type,
      this.ticketId,
      this.shopperId,
      this.orderName,
      this.orderWeight,
      this.orderPrice,
      this.orderDescription,
      this.buttonText,
      this.userName,
      this.userSurname,
      this.page,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == 0) {
          waitingPopUpTicket(context, this);
        } else if (type == 1) {
          inProgressPopUpTicket(context, this);
        } else if (type == 3) {
          completedPopUpTicket(context, this);
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
                Flexible(
                  flex: 3,
                  child: Container(
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
                ),

                //TICKET INFO
                Flexible(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: Text(
                            orderName,
                            overflow: TextOverflow.ellipsis,
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
                              child: Text(orderWeight.toString())),
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
                              child: Text(orderDistance.toString())),
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
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                      margin: const EdgeInsets.all(12),
                      color: Colors.yellowAccent,
                      padding: const EdgeInsets.all(7),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Text(
                              orderPrice.toString(),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child:
                                SvgPicture.asset('assets/icons/Currency.svg'),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            //Button

            ElevatedButton(
                onPressed: () async {
                  if (type == 0) {
                    await cancelOffer(ticketId);
                    popUpRequestCanceled(page.context);
                    page.setState(() {});
                  } else if (type == 1) {
                    var result = await cancelBookOfTicket(ticketId);
                    if (result) {
                      popUpRequestCanceled(page.context);
                      page.setState(() => {});
                    }
                  } else if (type == 3) {}
                },
                style: roundedWhite,
                child: SizedBox(
                  width: 150,
                  height: 32,
                  child: TextAndArrowButtonChild(buttonText: buttonText),
                )),
          ],
        ),
      ),
    );
  }
}
