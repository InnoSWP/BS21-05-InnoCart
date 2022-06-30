import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../ticket.dart';
import '../Buttons/elevated_button_style.dart';
import 'pop_up_notify.dart';
import '../main.dart';

Future popUpTicket(BuildContext context, Ticket ticket) {
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
                  ticket.orderName,
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
                      ticket.orderImage,
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
                              child: Text(ticket.orderWeight.toString())),
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
                              child: Text(ticket.orderDistance)),
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
                              child: Text(ticket.orderDate)),
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
                              child: Text(ticket.orderTime)),
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
                          ticket.reward.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SvgPicture.asset('assets/icons/Currency.svg'),
                    ],
                  )),
              Container(
                alignment: Alignment.topLeft,
                child: Text(ticket.orderInfo),
              ),
              Row(
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
                      child: TextAndArrowButtonChild(
                          buttonText: ticket.buttonText),
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
