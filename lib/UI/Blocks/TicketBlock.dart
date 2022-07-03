import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import '../../PopUp.dart';
import '../../main.dart';
import '../../ticket.dart';

class TicketBlock extends StatelessWidget {
  final Ticket ticket;
  final Widget lowBar;
  final Widget windowLowBar;

  const TicketBlock(
      {Key? key,
      required this.ticket,
      required this.lowBar,
      required this.windowLowBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        popUpTicket(context, ticket, windowLowBar);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: bottomPadding),
        padding: const EdgeInsets.all(20),
        width: 345,
        height: 245,
        color: Colors.white,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Row(
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
                    ticket.ticketImage,
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
                        ticket.title,
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
                            child: Text("${ticket.weight} KG")),
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
                            child: Text(ticket.distance)),
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
                            child: Text(ticket.deadlineUnixTime)),
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
          ),
          lowBar,
        ]),
      ),
    );
  }
}
