import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'set_ticket.dart';
import '../elevated_button_style.dart';
import 'pop_up_notify.dart';
import '../main.dart';

Future popUpTicket(BuildContext context, Ticket ticket) {
  String buttonText = ticket.buttonText;
  String profilePicture = ticket.profilePicture;
  String orderImage = ticket.orderImage;
  String orderName = ticket.orderName;
  double orderWeight = ticket.orderWeight;
  String orderDistance = ticket.orderDistance;
  String orderTime = ticket.orderTime;
  String orderDate = ticket.orderDate;
  String reward = ticket.reward;
  String orderInfo = ticket.orderInfo;
  String shopperName = ticket.userName;

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Container(
          height: 350,
          margin: const EdgeInsets.only(bottom: bottomPadding),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Text(
                  orderName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //PICTURE
                  Container(
                    width: 130,
                    height: 130,
                    color: Colors.blueGrey,
                    child: Image.asset(
                      orderImage,
                      fit: BoxFit.fill,
                    ),
                  ),

                  //TICKET INFO

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              child: Text(orderDistance)),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/Calendar_light.svg',
                            color: Colors.black,
                            width: 24,
                            height: 24,
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(orderDate)),
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
                ],
              ),
              Container(
                  color: Colors.yellowAccent,
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Text(
                          reward.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SvgPicture.asset('assets/icons/Currency.svg'),
                    ],
                  )),
              Container(
                alignment: Alignment.topLeft,
                child: Text(orderInfo),
              ),
              Row(
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
                      popUpRequestSentNotifier(context);
                    },
                    style: roundedWhite,
                    child: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            buttonText,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
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
              ),
              //Button
            ],
          ),
        ),
      );
    },
  );
}
