import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inno_cart/backend_functions.dart';
import 'package:inno_cart/profile_screen.dart';
import '../elevated_button_style.dart';
import '../main.dart';
import 'pop_up_window_with_ticket.dart';


class Ticket extends StatelessWidget {
  late int ticketId = 0;
  late int shopperId = 0;

  static const String buttonText = 'Send request';
  static const String profilePicture = 'assets/images/man1.png';
  static const String orderImage = 'assets/images/pizza.jpg';
  late String? orderName;
  late double orderWeight = 3.0;
  static const String orderDistance = '124 m';
  late String orderTime = '14:00';
  late String orderDate = '03.06.2022';
  late String reward = '';
  late String orderInfo = 'I want two DoDo peperoni pizzas, thank you!';
  late String userName = "";
  late String userSurname = "";
  late String userNickname = "";
  late double userRating = 0;


  Ticket(Map<String, dynamic> data, {Key? key}) : super(key: key) {
    /*print('Initialization of ticket entity');
    this.shopperName = data['user_id'].toString();
    this.orderName = data['title'];*/
    ticketId = data['ticket_id'];
    shopperId = data['shopper_id'];
    orderName = data['title'];
    orderWeight = data['weight'];
    userName = data['shopper_info']['name'];
    userSurname = data['shopper_info']['surname'];
    userNickname = data['shopper_info']['nickname'];
    userRating = data['shopper_info']['rating'];
    orderInfo = data['description'];
    reward = data['reward'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return
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
                          orderName!,
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
                                child: Text("$orderWeight KG")),
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
                                child: const Text(orderDistance)),
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
                            Text(reward.toString()),
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
                            GestureDetector(onTap: (() {
                               Navigator.push(context, MaterialPageRoute(builder: ((context)=>ProfilePage(ok:1,rating: userRating, email: '${userSurname}@mail.ru', telegram: '@$userName',))));
                            }),
                              child: const CircleAvatar(
                                radius: (20),
                                backgroundImage: AssetImage(profilePicture),
                              ),),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Text(userName),
                                  RatingBar.builder(
                                    initialRating: userRating,
                                    ignoreGestures: true,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 10,
                                    itemBuilder: (context, _) =>
                                    const Icon(
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
                              bookTicket(ticketId);
                              Navigator.of(context)
                                  .pushReplacementNamed('/PageOfActiveOrders');
                            },
                            style: roundedWhite,
                            child: SizedBox(
                              width: 150,
                              height: 32,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: const [
                                  Text(
                                    buttonText,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  Icon(
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
          ));
  }
}