import 'package:flutter/material.dart';

// import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:inno_cart/PageOfAngelOrders/pop_up_notify.dart';
import '../backend_functions.dart';
import 'pop_up_window_with_ticket.dart';
import '../elevated_button_style.dart';
import '../navigation_bar.dart';
import '../main.dart';
import 'app_bar.dart';
import '../profile_screen.dart';

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
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: appBar(context),
                bottomNavigationBar: makeNavigationBar(context, this),
                body: FutureBuilder<List<Widget>>(
                    future: Tickets(context, this).getTickets(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView(children: snapshot.data!);
                      } else {
                        return const Text('Waiting for data');
                      }
                    })),
            onHorizontalDragEnd: ((DragEndDetails details) {
              if (details.primaryVelocity! < 0.0) {
                pageUpdate((selectedPage + 1) % 5, context);
              } else if (details.primaryVelocity! > 0.0) {
                pageUpdate((selectedPage + 4) % 5, context);
              }
            }))); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class Tickets {
  late PageOfAngelOrdersState page;
  late List<Widget> waitingForAccept;
  late List<Widget> inProgress;
  late List<Widget> completed;

  Tickets(BuildContext context, this.page);

  Future<List<Widget>> getTickets() async {
    Map<String, dynamic> waitingForAcceptHistoryTickets =
        await getTicketHistory(0, 1);
    Map<String, dynamic> inProgressHistoryTickets =
        await getTicketHistory(1, 1);
    Map<String, dynamic> completedHistoryTickets = await getTicketHistory(2, 1);
    List<Widget> listToReturn = [];
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

  AbstractAngelHistoryTicket createTicketFromData(Map<String, dynamic> data) {
    if (data['status'] == 0) {
      return AngelWaitingForAcceptHistoryTicket(
          data['ticket_id'],
          data['shopper_id'],
          data['title'],
          data['weight'],
          data['reward'],
          data['description'],
          data['shopper_info']['surname'],
          data['shopper_info']['name'],
          page);
    } else if (data['status'] == 1) {
      return AngelInProgressHistoryTicket(
          data['ticket_id'],
          data['shopper_id'],
          data['angel_id'],
          data['title'],
          data['weight'],
          data['reward'],
          data['description'],
          data['shopper_info']['surname'],
          data['shopper_info']['name'],
          page);
    } else if (data['status'] == 2) {
      return AngelCompletedHistoryTicket(
          data['ticket_id'],
          data['shopper_id'],
          data['angel_id'],
          data['title'],
          data['weight'],
          data['reward'],
          data['description'],
          data['shopper_info']['surname'],
          data['shopper_info']['name'],
          page);
    }
    return AbstractAngelHistoryTicket(
        data['ticket_id'],
        data['shopper_id'],
        data['title'],
        data['weight'],
        data['reward'],
        data['description'],
        data['shopper_info']['surname'],
        data['shopper_info']['name'],
        "UNKNOWN ERROR",
        page);
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

class AbstractAngelHistoryTicket extends StatelessWidget {
  int ticketId = 0;
  int shopperId = 0;
  int type = -1;

  String orderImage = 'assets/images/man1.png';
  String orderName = "";
  double orderWeight = 0;
  String userName = 'kek';
  String userSurname = 'kek';
  static const double orderDistance = 100; // OVERRIDE IN MVP V2
  static const String orderTime = "23.06.2022"; // OVERRIDE IN MVP V2
  double orderPrice = 0;
  String buttonText = "";
  late PageOfAngelOrdersState page;
  String orderDescription = "";

  AbstractAngelHistoryTicket(
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

  Future<void> onButtonPress() async {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
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
                GestureDetector(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ProfilePage(
                                  ok: 1,
                                  rating: 4,
                                  email: '${userSurname}@mail.ru',
                                  telegram: '@$userName',
                                ))));
                  }),
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
                            child: const Text(orderTime)),
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
                        Text(orderPrice.toString()),
                        SvgPicture.asset('assets/icons/Currency.svg'),
                      ],
                    )),
              ],
            ),
            //Button

            ElevatedButton(
                onPressed: () {
                  onButtonPress();
                },
                style: roundedWhite,
                child: SizedBox(
                  width: 150,
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        buttonText,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
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
    );
  }
}

class AngelWaitingForAcceptHistoryTicket extends AbstractAngelHistoryTicket {
  AngelWaitingForAcceptHistoryTicket(
      int ticketId,
      int shopperId,
      String orderName,
      double orderWeight,
      double orderPrice,
      String orderDescription,
      String userName,
      String userSurname,
      PageOfAngelOrdersState page,
      {Key? key})
      : super(
            key: key,
            ticketId,
            shopperId,
            orderName,
            orderWeight,
            orderPrice,
            orderDescription,
            "Cancel request",
            userName,
            userSurname,
            page) {
    super.type = 0;
  }

  @override
  Future<void> onButtonPress() async {}
}

class AngelInProgressHistoryTicket extends AbstractAngelHistoryTicket {
  int angelId = 0;

  AngelInProgressHistoryTicket(
      int ticketId,
      int shopperId,
      this.angelId,
      String orderName,
      double orderWeight,
      double orderPrice,
      String orderDescription,
      String userName,
      String userSurname,
      PageOfAngelOrdersState page,
      {Key? key})
      : super(
            key: key,
            ticketId,
            shopperId,
            orderName,
            orderWeight,
            orderPrice,
            orderDescription,
            "Cancel (Rewrite)",
            userName,
            userSurname,
            page) {
    super.type = 1;
  }

  @override
  Future<void> onButtonPress() async {
    bool result = await cancelBookOfTicket(ticketId);
    if (result) {
      Navigator.of(page.context).pushReplacementNamed('/ShopperOrders');
    }
  }
}

class AngelCompletedHistoryTicket extends AbstractAngelHistoryTicket {
  int angelId = 0;

  AngelCompletedHistoryTicket(
      int ticketId,
      int shopperId,
      this.angelId,
      String orderName,
      double orderWeight,
      double orderPrice,
      String orderDescription,
      String userName,
      String userSurname,
      PageOfAngelOrdersState page,
      {Key? key})
      : super(
            key: key,
            ticketId,
            shopperId,
            orderName,
            orderWeight,
            orderPrice,
            orderDescription,
            "Rate Shopper",
            userName,
            userSurname,
            page) {
    super.type = 3;
  }

  @override
  Future<void> onButtonPress() async {}
}
