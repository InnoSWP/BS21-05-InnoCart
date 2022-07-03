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
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //PICTURE
                Flexible(
                  flex: 4,
                  child: SizedBox(
                    width: 130,
                    height: 130,
                    child: Image.network(
                      ticket.ticketImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),

                //TICKET INFO
                Flexible(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          ticket.title,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(fontSize: 18),
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
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                      color: Colors.yellowAccent,
                      padding: const EdgeInsets.all(6),
                      child: Row(
                        children: [
                          Flexible(
                              flex: 3,
                              child: SizedBox(
                                width: 50,
                                child: Text(
                                  ticket.reward.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                          Flexible(
                              flex: 1,
                              child: SvgPicture.asset(
                                  'assets/icons/Currency.svg')),
                        ],
                      )),
                ),
              ],
            ),
          ),
          lowBar,
        ]),
      ),
    );
  }
}
