import 'package:flutter/material.dart';
import '../../backend_functions.dart';
import '../../ticket.dart';
import '../page_of_shopper_orders.dart';
import '../../UI/PopUpWindows/order_canceled.dart';
import '../../UI/Buttons/elevated_button_style.dart';

Widget waiting(BuildContext context, Ticket ticket, String buttonText,
    PageOfShopperOrdersState page) {
  return ElevatedButton(
    onPressed: () async {
      bool result = await cancelOrder(ticket.ticketId);
      if (result) {
        Navigator.of(context).pop();
        popUpOrderCanceled(context);
        page.setState(() {});
      }
    },
    style: roundedWhite,
    child: SizedBox(
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            buttonText,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 14,
          ),
        ],
      ),
    ),
  );
}
