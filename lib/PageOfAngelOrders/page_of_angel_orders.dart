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
    List<Widget> listToReturn = [];

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

  SetTicket createTicketFromData(Map<String, dynamic> data) {
    return SetTicket(Ticket(data));
  }
}

class SetTicket extends StatelessWidget {
  final Ticket ticket;
  final String buttonText = 'test';
  const SetTicket(this.ticket, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*if (type == 0) {
          waitingPopUpTicket(context, this);
        } else if (type == 1) {
          inProgressPopUpTicket(context, this);
        } else if (type == 3) {
          completedPopUpTicket(context, this);
        }*/
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
                      ticket.ticketImage,
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
                            ticket.title,
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
                              child: Text(ticket.weight.toString())),
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
                              child: Text(ticket.distance.toString())),
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
                              child: Text(ticket.deadlineUnixTime)),
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
                              ticket.reward.toString(),
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
                  /*if (type == 0) {
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

                   */
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
