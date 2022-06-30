import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../main.dart';
import '../../ticket.dart';

class TicketWindow extends StatelessWidget {
  final Ticket ticket;
  final Widget lowBar;

  const TicketWindow({Key? key, required this.ticket, required this.lowBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          lowBar,
        ],
      ),
    );
  }
}
