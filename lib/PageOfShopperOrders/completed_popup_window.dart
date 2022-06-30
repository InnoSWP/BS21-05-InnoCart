import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'page_of_shopper_orders.dart';
import '../Buttons/elevated_button_style.dart';
import '../main.dart';

Future completedPopUpTicket(
    BuildContext context, AbstractHistoryTicket ticket) {
  String buttonText = ticket.buttonText;
  String profilePicture = 'assets/images/man1.png';
  String orderImage = ticket.orderImage;
  String orderName = ticket.orderName;
  double orderWeight = ticket.orderWeight;
  double orderDistance = ticket.orderDistance;
  String orderTime = ticket.orderTime;
  String orderDate = ticket.orderDate;
  double orderPrice = ticket.orderPrice;
  String orderDescription = ticket.orderDescription;
  String orderAngel = 'Amr. T.';

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
            children: [
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
                      Text(
                        orderName,
                        style: const TextStyle(fontSize: 20),
                      ),
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

                  Container(
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
              Container(
                alignment: Alignment.topLeft,
                child: Text(orderDescription),
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
                            Text(orderAngel),
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
