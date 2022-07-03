import 'dart:convert';
import 'package:flutter/material.dart';
import '../PageOfActiveOrders/app_bar.dart';
import '../ServerURL.dart';
import '../navigation_bar.dart';
import '../ticket.dart';
import 'set_ticket.dart';
import '../backend_functions.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../firebase_functions.dart';

class PageOfActiveOrders extends StatefulWidget {
  const PageOfActiveOrders({Key? key}) : super(key: key);

  @override
  State<PageOfActiveOrders> createState() => PageOfActiveOrdersState();
}

class PageOfActiveOrdersState extends State<PageOfActiveOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onHorizontalDragEnd: ((DragEndDetails details) {
          if (details.primaryVelocity! < 0.0) {
            pageUpdate((selectedPage + 1) % 5, context);
          } else if (details.primaryVelocity! > 0.0) {
            pageUpdate((selectedPage + 4) % 5, context);
          }
        }),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: const ThisAppBar(),
          bottomNavigationBar: const MainNavigationBar(),
          body: FutureBuilder<List<Widget>>(
              future: getTickets(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(children: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }

  Future<List<Widget>> getTickets() async {
    List<Widget> tickets = [];

    Uri uri = Uri.parse(
        "http://$serverURL/getTicketsForUser?user_id=${currentUser.userId}&user_token=${currentUser.token}");

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(
          response.body.replaceAll("'", '"').replaceAll("None", '""'));

      for (Map<String, dynamic> ticketNote in jsonData['tickets']) {
        String url ='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU';
        if (await ticketExists(ticketNote['ticket_id'])){
          url = await getUrlByTicketId(ticketNote['ticket_id']);
        }
        String url1 = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU';
        if (await userExists(ticketNote['shopper_id'])){
          url1 = await getUrlByUserId(ticketNote['shopper_id']);
        }
    tickets.add(SetTicket(ticket: Ticket(ticketNote, url, url1)));
      }
    }

    return tickets;
  }
}
