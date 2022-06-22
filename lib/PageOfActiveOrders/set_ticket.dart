import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../elevated_button_style.dart';
import '../main.dart';
import 'pop_up_window_with_ticket.dart';

List<Widget> Ticket(BuildContext context) {
  String buttonText = 'Send request';
  String profilePicture = 'assets/images/man1.png';
  String orderImage = 'assets/images/pizza.jpg';
  String orderName = 'Pizza';
  String orderWeight = '3 kg';
  String orderDistance = '124 m';
  String orderTime = '14:00';
  String orderDate = '03.06.2022';
  String orderPrice = '200';
  String orderInfo = 'I want two DoDo peperoni pizzas, thank you!';
  String shopperName = 'Amr. T.';

  return [
    GestureDetector(
        onTap: () => popUpTicket(context),
        child: Container(
          margin: const EdgeInsets.only(bottom: bottomPadding),
          padding: const EdgeInsets.all(20),
          width: 345,
          height: 230,
          color: Colors.white,
          child: Column(
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
                    //margin: const EdgeInsets.only(top: 12, left: 12, bottom: 10),
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
                              child: Text(orderWeight)),
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
                          Text(orderPrice),
                          SvgPicture.asset('assets/icons/Currency.svg'),
                        ],
                      )),
                ],
              ),
              //Button
              Container(
                  margin: const EdgeInsets.only(top: 10),
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
                                    print(rating);
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
                          style: RoundedWhite,
                          child: SizedBox(
                            width: 150,
                            height: 32,
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
                          )),
                    ],
                  )),
            ],
          ),
        ))
  ];
}
