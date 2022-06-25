import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inno_cart/PageOfShopperOrders/pop_up_notify.dart';

import '../elevated_button_style.dart';

Future seeRequestWindow(BuildContext context) {
  String buttonText = 'Cancel Order';
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              setAngel(),
              setAngel(),
              setAngel(),
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    popUpOrderCanceled(context);
                  },
                  style: roundedWhite,
                  child: Text(
                    buttonText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget setAngel() {
  String buttonText = 'Accept';
  String profilePicture = 'assets/images/man1.png';
  String shopperName = 'Amr. T.';
  return Container(
      //margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: (20),
                backgroundImage: AssetImage(profilePicture),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    Text(shopperName),
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
                //popUpRequestSentNotifier(context);
              },
              style: roundedWhite,
              child: SizedBox(
                width: 90,
                height: 32,
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
              )),
        ],
      ));
}
