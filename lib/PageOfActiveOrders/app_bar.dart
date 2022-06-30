import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../UI/Buttons/elevated_button_style.dart';

class ThisAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ThisAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<ThisAppBar> createState() => ThisAppBarState();
}

class ThisAppBarState extends State<ThisAppBar> {
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: () => selectDate(),
              style: roundedWhite,
              child: SizedBox(
                  width: 130,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/Calendar_light.svg'),
                      const Text(
                        'Choose date',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ))),
          PopupMenuButton(
              icon: SvgPicture.asset(
                'assets/icons/Filter Icon.svg',
                color: Colors.black,
              ),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      value: 0,
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Type',
                            ),
                          ),
                          Container(
                              width: 180,
                              padding: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                  style: roundedWhite,
                                  onPressed: () {},
                                  child: const Text(
                                    'All',
                                    style: TextStyle(color: Colors.black),
                                  ))),
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
                              hintText: 'Enter max weight (kg)',
                            ),
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
    );
  }
}
