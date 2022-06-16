import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'NavigationBar.dart';

class PageOfActiveOrders extends StatefulWidget {
  const PageOfActiveOrders({Key? key}) : super(key: key);

  @override
  State<PageOfActiveOrders> createState() => _PageOfActiveOrdersState();
}

class _PageOfActiveOrdersState extends State<PageOfActiveOrders> {
  DateTime selectedDate = DateTime.now();
  Widget dropdownvalue = Text('1');

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

const int gray = 0xe5e5e5e5;
const double bottomPadding = 29;

class Tickets {
  late List<Widget> waitingForAccept;

  Tickets(BuildContext context) {
    waitingForAccept =
        setTicket(context) + setTicket(context) + setTicket(context);
  }

  List<Widget> getTickets() {
    return waitingForAccept;
  }

  Future popUpTicket(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Container(
              width: 313,
              height: 355,
              child: ListView(
                children: const [
                  CircleAvatar(
                    radius: (50),
                    backgroundImage: AssetImage('assets/images/man.jpg'),
                  ),
                ],
              ),
            ));
      },
    );
  }

  List<Widget> setTicket(BuildContext context) {
    return [
      Container(
        margin: const EdgeInsets.only(bottom: bottomPadding),
        width: 345,
        height: 208,
        color: const Color(gray),
        child: Column(
          children: [
            GestureDetector(
                onTap: () => popUpTicket(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //PICTURE
                    Container(
                      width: 130,
                      height: 130,
                      color: Colors.blueGrey,
                      margin:
                          const EdgeInsets.only(top: 12, left: 12, bottom: 10),
                    ),

                    //TICKET INFO

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: const Text(
                              'Pizza',
                              style: TextStyle(fontSize: 20),
                            )),
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
                                child: const Text('2 kg')),
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
                                child: const Text('124 m')),
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
                                child: const Text('14:00')),
                          ],
                        ),
                      ],
                    ),

                    Container(
                        margin: const EdgeInsets.all(12),
                        color: Colors.yellowAccent,
                        padding: const EdgeInsets.all(6),
                        child: Row(
                          children: [
                            const Text('100'),
                            SvgPicture.asset('assets/icons/Currency.svg'),
                          ],
                        )),
                  ],
                )),
            //Button

            ElevatedButton(
                onPressed: () {},
                child: Container(
                    width: 150,
                    height: 32,
                    child: Center(
                        child: Text(
                      'Send request',
                      style: const TextStyle(fontSize: 14),
                    )))),
          ],
        ),
      )
    ];
  }
}
