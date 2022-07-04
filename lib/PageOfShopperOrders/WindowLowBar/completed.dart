import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../UI/PopUpWindows/rate_window.dart';
import '../../ticket.dart';
import '../page_of_shopper_orders.dart';
import '../../UI/Buttons/elevated_button_style.dart';

Widget completed(BuildContext context, Ticket ticket, String buttonText,
    PageOfShopperOrdersState page) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: (20),
            backgroundImage: NetworkImage(ticket.angel.profileImage),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              children: [
                Text(ticket.angel.name),
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
        onPressed: () {
          Navigator.pop(context);
          rateWindow(context, ticket, UserType.shopper);
          page.setState(() {});
        },
        style: roundedWhite,
        child: SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                buttonText,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
