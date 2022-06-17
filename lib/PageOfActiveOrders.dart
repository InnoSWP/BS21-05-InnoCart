import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'NavigationBar.dart';
import 'SetTicket.dart';
import 'PopUpTicket.dart';
import 'main.dart';

class PageOfActiveOrders extends StatefulWidget {
  const PageOfActiveOrders({Key? key}) : super(key: key);

  @override
  State<PageOfActiveOrders> createState() => _PageOfActiveOrdersState();
}

class _PageOfActiveOrdersState extends State<PageOfActiveOrders> {
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () => selectDate(context),
                      child: SizedBox(
                          width: 130,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.calendar_today_outlined),
                              Text('Choose date'),
                            ],
                          ))),
                  PopupMenuButton(
                      icon: SvgPicture.asset(
                        'assets/icons/Filter Icon.svg',
                        color: Colors.black,
                      ),
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              value: 0,
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Type',
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                const Size.fromHeight(40),
                                          ),
                                          onPressed: () {},
                                          child: const Text('All'))),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              padding: const EdgeInsets.all(20),
                              value: 0,
                              child: Column(
                                children: const [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Weight',
                                    ),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Enter max weight (kg)'),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              padding: const EdgeInsets.only(
                                  bottom: 20, left: 20, right: 20),
                              value: 0,
                              child: Column(
                                children: const [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Distance',
                                    ),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Enter max distance (m)'),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/Filter Seacrh.svg',
                        color: Colors.black),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: makeNavigationBar(context, this),
            body: ListView(
              children: Tickets(context).getTickets(),
            ))); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class Tickets {
  late List<Widget> waitingForAccept;

  Tickets(BuildContext context) {
    waitingForAccept =
        setTicket(context) + setTicket(context) + setTicket(context);
  }

  List<Widget> getTickets() {
    return waitingForAccept;
  }
}
