import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../ticket.dart';
import 'pop_up_notify.dart';
import '../backend_functions.dart';
import '../ProfilePages/profile_screen.dart';
import '../Buttons/elevated_button_style.dart';
import '../main.dart';
import 'pop_up_window_with_ticket.dart';

class SetTicket extends StatelessWidget {
  final Ticket ticket;

  const SetTicket({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => popUpTicket(context, ticket),
      child: Container(
        margin: const EdgeInsets.only(bottom: bottomPadding),
        padding: const EdgeInsets.all(20),
        width: 345,
        height: 230,
        color: Colors.white,
        child: Column(children: [
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
                  ticket.orderImage,
                  fit: BoxFit.fill,
                ),
              ),

              //TICKET INFO

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 170,
                    child: Text(
                      ticket.orderName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 20),
                    ),
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
                          child: Text("${ticket.orderWeight} KG")),
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
              Container(
                  color: Colors.yellowAccent,
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          ticket.reward.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
                      GestureDetector(
                        onTap: (() async {
                          Map<String, dynamic> data =
                          await contactUserInformationById(ticket.shopperId);
                          print(data);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ProfilePage(
                                        ok: 1,
                                        rating: data['rating'],
                                        email: data['email'],
                                        telegram: data['telegram'],
                                      ))));
                        }),
                        child: CircleAvatar(
                          radius: (20),
                          backgroundImage: AssetImage(ticket.profilePicture),
                        ),
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
                              onRatingUpdate: (double value) {},
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // bookTicket(ticketId); REPLACEMENT TO OFFER REQUEST
                      popUpRequestSentNotifier(context);
                      sendOfferToBookTicket(ticket.ticketId);
                      // Navigator.of(context)
                      //     .pushReplacementNamed('/PageOfActiveOrders');
                    },
                    style: roundedWhite,
                    child: SizedBox(
                      width: 150,
                      height: 32,
                      child: TextAndArrowButtonChild(
                          buttonText: ticket.buttonText),
                    ),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}
