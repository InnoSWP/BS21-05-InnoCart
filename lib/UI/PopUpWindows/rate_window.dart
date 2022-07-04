import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../ticket.dart';

Future rateWindow(
  BuildContext context,
  Ticket ticket,
  UserType userType,
) {
  // its not mistake
  final String text = ((userType == UserType.angel) ? 'Shopper' : 'Angel');
  final String titleText = 'How would you rate the $text work?';

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(
                    titleText,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      ticket.angel.name,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: CircleAvatar(
                    radius: (55),
                    backgroundImage: NetworkImage(ticket.shopper.profileImage),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: RatingBar.builder(
                    initialRating: 0,
                    ignoreGestures: false,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (double value) {
                      //TODO
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
