import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'pop_up_notify.dart';
import 'page_of_angel_orders.dart';
import '../UI/Buttons/elevated_button_style.dart';
import '../main.dart';

Future waitingPopUpTicket(BuildContext context, TicketTMP ticket) {
  String profilePicture = 'assets/images/man1.png';
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
                      ticket.orderImage,
                      fit: BoxFit.fill,
                    ),
                  ),

                  //TICKET INFO

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ticket.orderName,
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
                              child: Text(ticket.orderDistance.toString())),
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

                  Container(
                      color: Colors.yellowAccent,
                      padding: const EdgeInsets.all(6),
                      child: Row(
                        children: [
                          Text(ticket.orderPrice.toString()),
                          SvgPicture.asset('assets/icons/Currency.svg'),
                        ],
                      )),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(ticket.orderDescription),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  popUpRequestCanceled(context);
                },
                style: roundedWhite,
                child: SizedBox(
                  width: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticket.buttonText,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black),
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
        ),
      );
    },
  );
}
