import 'dart:convert';

import 'package:flutter/material.dart';
import '../PageOfActiveOrders/app_bar.dart';
import '../navigation_bar.dart';
import 'set_ticket.dart';
import 'package:inno_cart/backend_functions.dart';
import 'package:http/http.dart' as http;

class PageOfActiveOrders extends StatefulWidget {
  const PageOfActiveOrders({Key? key}) : super(key: key);

  @override
  State<PageOfActiveOrders> createState() => PageOfActiveOrdersState();
}

class PageOfActiveOrdersState extends State<PageOfActiveOrders> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(context, this),
            bottomNavigationBar: makeNavigationBar(context, this),
            body: FutureBuilder<List<Widget>>(
              future: Tickets(context).getTickets(),
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return ListView(
                    children: snapshot.data!
                  );
                }
                else{
                  return const Text("waiting for data");
                }
              }
            ))); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class Tickets {
  List<Widget> waitingForAccept = [];
  BuildContext context;

  Tickets(this.context) {
    print("Tickets class has been initialized!");
  }

  Future<List<Widget>> getTickets() async {
    //waitingForAccept =
    //    Ticket(context) + Ticket(context) + Ticket(context);
    print("Running function get Tickets");
    Map<String, dynamic> args = {
      "user_id": currentUser.userId,
      "user_token": currentUser.passwordHash
    };
    print("Map of arguments had been constructed correctly");
    print(serverURL);
    print(args);
    Uri uri = Uri.parse(
        "http://127.0.0.1:8000/getTicketsForUser?user_id=${currentUser.userId}&user_token=${currentUser.token}"
    );
    print(uri);
    http.Response response = await http.get(uri);
    print(response.statusCode);

    if (response.statusCode == 200){
      Map<String, dynamic> jsonData = jsonDecode(
        response.body.replaceAll("'", '"').replaceAll("None", '\"\"')
      );
      print(jsonData['tickets'][0]);
      for (Map<String, dynamic> ticketNote in jsonData['tickets']){
        print(ticketNote);
        waitingForAccept.add(Ticket(ticketNote));
      }
    }
    else{
      return [];
    }
    print(waitingForAccept);
    return waitingForAccept;
  }
}
