import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inno_cart/main.dart';
import '../UI/Blocks/TicketBlock.dart';
import '../ticket.dart';
import '../UI/PopUpWindows/request_sent.dart';
import '../backend_functions.dart';
import '../ProfilePages/profile_screen.dart';
import '../UI/Buttons/elevated_button_style.dart';

class SetTicket extends StatelessWidget {
  final Ticket ticket;
  final String buttonText = 'Send request';
  const SetTicket({Key? key, required this.ticket}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Widget lowBar = Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            GestureDetector(
              onTap: (() async {
                selectedPage = 4;
                Map<String, dynamic> data =
                    await contactUserInformationById(ticket.shopperId);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ProfilePage(
                              ok: 1,
                              rating: data['rating'],
                              email: data['email'],
                              telegram: data['telegram'],
                            ))));
              }),
              child: CircleAvatar(
                radius: (20),
                backgroundImage: Image.network(ticket.shopper.profileImage).image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Text(ticket.shopper.name),
                  RatingBar.builder(
                    initialRating: ticket.shopper.rating,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 10,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (double value) {},
                  )
                ],
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            // bookTicket(ticketId); REPLACEMENT TO OFFER REQUEST
            popUpRequestSentNotifier(context);
            sendOfferToBookTicket(ticket.ticketId);
            // Navigator.of(context)
            //     .pushReplacementNamed('/PageOfActiveOrders');
          },
          style: roundedWhite,
          child: SizedBox(
            width: 150,
            height: 32,
            child: TextAndArrowButtonChild(buttonText: buttonText),
          ),
        ),
      ]),
    );

    Widget windowLowBar = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: (20),
              backgroundImage: AssetImage(ticket.shopper.profileImage),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  Text(ticket.shopper.name),
                  RatingBar.builder(
                    initialRating: ticket.shopper.rating,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 10,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            popUpRequestSentNotifier(context);
          },
          style: roundedWhite,
          child: SizedBox(
            width: 120,
            child: TextAndArrowButtonChild(buttonText: buttonText),
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
