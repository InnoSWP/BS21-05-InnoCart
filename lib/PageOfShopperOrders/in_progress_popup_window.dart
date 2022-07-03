import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../ticket.dart';
import 'page_of_shopper_orders.dart';
import 'pop_up_notify.dart';
import '../UI/Buttons/elevated_button_style.dart';
import '../main.dart';

Widget inProgress(BuildContext context, Ticket ticket, String buttonText,
    PageOfShopperOrdersState page) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: (20),
            backgroundImage: AssetImage(ticket.angel.profileImage),
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
          popUpOrderCanceled(context);
          page.setState(() {});
        },
        style: roundedWhite,
        child: SizedBox(
          width: 120,
          child: TextAndArrowButtonChild(
            buttonText: buttonText,
          ),
        ),
      ),
    ],
  );
}
