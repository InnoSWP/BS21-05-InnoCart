import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../UI/PopUpWindows/ticket_window.dart';
import '../ticket.dart';
import '../UI/Buttons/elevated_button_style.dart';
import 'UI/PopUpWindows/request_sent.dart';

Future popUpTicket(BuildContext context, Ticket ticket, Widget windowLowBar) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: TicketWindow(ticket: ticket, lowBar: windowLowBar),
      );
    },
  );
}
