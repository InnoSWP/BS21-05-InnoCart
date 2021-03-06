import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inno_cart/UI/PopUpWindows/rate_window.dart';
import '../UI/Blocks/TicketBlock.dart';
import '../ticket.dart';
import '../UI/PopUpWindows/request_canceled.dart';
import '../backend_functions.dart';
import '../UI/Buttons/elevated_button_style.dart';
import '../navigation_bar.dart';
import '../main.dart';
import 'app_bar.dart';
import '../firebase_functions.dart';

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
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })))); // This trailing comma makes auto-formatting nicer for build methods.
  }

  Future<List<Widget>> getTickets() async {
    // url - ticket picture
    // url1 - shopper picture
    List<Widget> listToReturn = [];

    Map<String, dynamic> waitingForAcceptHistoryTickets =
        await getOfferedTickets();
    Map<String, dynamic> inProgressHistoryTickets =
        await getTicketHistory(1, 1);
    Map<String, dynamic> completedHistoryTickets = await getTicketHistory(2, 1);

    listToReturn.add(generateHeader('Waiting for accept'));

    for (Map<String, dynamic> tokenNote
        in waitingForAcceptHistoryTickets['tickets']) {
      String url =
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU';
      if (await ticketExists(tokenNote['ticket_id'])) {
        url = await getUrlByTicketId(tokenNote['ticket_id']);
      }
      String url1 =
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU';
      if (await userExists(tokenNote['shopper_id'])) {
        url1 = await getUrlByUserId(tokenNote['shopper_id']);
      }
      listToReturn.add(createTicketFromData(tokenNote, this, url, url1));
    }

    listToReturn.add(generateHeader('In progress'));

    for (Map<String, dynamic> tokenNote
        in inProgressHistoryTickets['tickets']) {
      String url =
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU';
      if (await ticketExists(tokenNote['ticket_id'])) {
        url = await getUrlByTicketId(tokenNote['ticket_id']);
      }
      String url1 =
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU';
      if (await userExists(tokenNote['shopper_id'])) {
        url1 = await getUrlByUserId(tokenNote['shopper_id']);
      }
      listToReturn.add(createTicketFromData(tokenNote, this, url, url1));
    }

    listToReturn.add(generateHeader('Completed'));

    for (Map<String, dynamic> tokenNote in completedHistoryTickets['tickets']) {
      String url =
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU';
      if (await ticketExists(tokenNote['ticket_id'])) {
        url = await getUrlByTicketId(tokenNote['ticket_id']);
      }
      String url1 =
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU';
      if (await userExists(tokenNote['shopper_id'])) {
        url1 = await getUrlByUserId(tokenNote['shopper_id']);
      }
      listToReturn.add(createTicketFromData(tokenNote, this, url, url1));
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

  SetTicket createTicketFromData(Map<String, dynamic> data,
      PageOfAngelOrdersState page, String url, String shopperPicture) {
    return SetTicket(
      Ticket(data, url, shopperPicture),
      page,
    );
  }
}

class SetTicket extends StatelessWidget {
  final PageOfAngelOrdersState page;
  final Ticket ticket;
  late final String buttonText;
  late final String buttonTextPopUp;

  SetTicket(this.ticket, this.page, {Key? key}) : super(key: key) {
    if (ticket.status == TicketType.waitingForAccept) {
      buttonText = 'Cancel Request';
      buttonTextPopUp = 'Cancel Request';
    } else if (ticket.status == TicketType.inProgress) {
      buttonText = 'Open chat';
      buttonTextPopUp = 'Cancel Request';
    } else if (ticket.status == TicketType.completed) {
      buttonText = 'Rate Shopper';
      buttonTextPopUp = 'Rate Shopper';
    }
  }

  @override
  Widget build(BuildContext context) {
    final lowBar = ElevatedButton(
        onPressed: () async {
          if (ticket.status == TicketType.waitingForAccept) {
            await cancelOffer(ticket.ticketId);
            popUpRequestCanceled(page.context);
            page.setState(() {});
          } else if (ticket.status == TicketType.inProgress) {
            selectedPage = 3;
            Navigator.of(context).pushReplacementNamed('/Messenger');
          } else if (ticket.status == TicketType.completed) {
            rateWindow(context, ticket, UserType.angel);
            page.setState(() => {});
          }
        },
        style: roundedWhite,
        child: SizedBox(
          width: 150,
          height: 32,
          child: TextAndArrowButtonChild(buttonText: buttonText),
        ));

    final Widget windowLowBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: (20),
              backgroundImage: Image.network(ticket.shopper.profileImage).image,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Text(ticket.shopper.name),
                  RatingBar.builder(
                    initialRating: 5,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 10,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      if (kDebugMode) {
                        print(rating);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () async {
            if (ticket.status == TicketType.waitingForAccept) {
              var result = await cancelOffer(ticket.ticketId);
              if (result) {
                Navigator.pop(context);
                popUpRequestCanceled(page.context);
                page.setState(() {});
              }
            } else if (ticket.status == TicketType.inProgress) {
              var result = await cancelOffer(ticket.ticketId);
              if (result) {
                Navigator.pop(context);
                popUpRequestCanceled(page.context);
                page.setState(() {});
              }
            } else if (ticket.status == TicketType.completed) {
              Navigator.pop(context);
              rateWindow(context, ticket, UserType.angel);
              page.setState(() => {});
            }
          },
          style: roundedWhite,
          child: SizedBox(
            width: 120,
            child: TextAndArrowButtonChild(
              buttonText: buttonTextPopUp,
            ),
          ),
        ),
      ],
    );

    return TicketBlock(
      ticket: ticket,
      lowBar: lowBar,
      windowLowBar: windowLowBar,
    );
  }
}
