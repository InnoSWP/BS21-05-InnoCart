import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../UI/PopUpWindows/ticket_window.dart';
import '../ticket.dart';
import '../UI/Buttons/elevated_button_style.dart';
import 'request_sent.dart';
/*
Future popUpTicket(BuildContext context, Ticket ticket) {
  Widget lowBar = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: (20),
            backgroundImage: AssetImage(ticket.profilePicture),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              children: [
                Text(ticket.userName),
                RatingBar.builder(
                  initialRating: ticket.userRating,
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
          child: TextAndArrowButtonChild(buttonText: ticket.buttonText),
        ),
      ),
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: TicketWindow(ticket: ticket, lowBar: lowBar),
      );
    },
  );
}
*/
