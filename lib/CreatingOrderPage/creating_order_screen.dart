import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../UI/Buttons/elevated_button_style.dart';
import '../backend_functions.dart';
import '../navigation_bar.dart';
import '../main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:file_picker/file_picker.dart';
import '../firebase_functions.dart';
import 'dart:io';

class OrderFactoryPage extends StatefulWidget {
  const OrderFactoryPage({Key? key}) : super(key: key);

  @override
  State<OrderFactoryPage> createState() => _OrderFactoryPageState();
}

class _OrderFactoryPageState extends State<OrderFactoryPage> {
  PlatformFile? pickedFile;
  String title = "";
  String description = "";
  String type = "";
  double reward = 0.0;
  double weight = 0.0;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
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

    return GestureDetector(
        onHorizontalDragEnd: ((DragEndDetails details) {
          if (details.primaryVelocity! < 0.0) {
            pageUpdate((selectedPage + 1) % 5, context);
          } else if (details.primaryVelocity! > 0.0) {
            pageUpdate((selectedPage + 4) % 5, context);
          }
        }),
        child: Scaffold(
          bottomNavigationBar: const MainNavigationBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  SizedBox(
                      height: 30,
                      child: TextField(
                        onChanged: (text) {
                          title = text;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.0)),
                          ),
                          hintText: 'Name',
                          contentPadding: EdgeInsets.only(top: 7, left: 5),
                        ),
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OutlinedButton(
                          onPressed: () => selectFile(),
                          child: Container(
                              padding: EdgeInsets.all(0.0),
                              width: 130,
                              height: 130,
                              child: pickedFile != null
                                  ? Image.file(
                                      File(pickedFile!.path!),
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      'https://www.pngkit.com/png/detail/129-1298005_png-file-upload-image-icon-png.png')),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(children: [
                          const SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: 150,
                            height: 30,
                            child: TextField(
                              onChanged: (text) {
                                try {
                                  weight = double.parse(text);
                                } on Exception {
                                  weight = 0.0;
                                }
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                ),
                                hintText: 'Enter weight',
                                suffix: Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Text('KG'),
                                ),
                                contentPadding:
                                    EdgeInsets.only(top: 7, left: 5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: 150,
                            height: 30,
                            child: TextField(
                              onChanged: (text) {
                                // WHY THIS FIELD IS TEXT?????? 8 )
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                ),
                                hintText: 'Add location',
                                contentPadding:
                                    EdgeInsets.only(top: 7, left: 5),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Additional info'),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: TextField(
                      onChanged: (text) {
                        description = text;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      onChanged: (text) {
                        type = text;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(7.0)),
                        ),
                        hintText: 'Type',
                        contentPadding: EdgeInsets.only(top: 7, left: 5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Reward'),
                        SizedBox(
                          width: 100,
                          height: 30,
                          child: TextField(
                            onChanged: (text) {
                              try {
                                reward = double.parse(text);
                              } on Exception {
                                reward = 0;
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(right: 0, top: 0),
                                child: SvgPicture.asset(
                                    'assets/icons/Currency.svg'),
                              ),
                              contentPadding: EdgeInsets.only(top: 7, left: 5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Deadline'),
                        ElevatedButton(
                            onPressed: () => selectDate(),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                              elevation: 0,
                              side: const BorderSide(
                                  color: Colors.black, width: 2),
                            ),
                            child: SizedBox(
                                width: 130,
                                height: 30,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/Calendar_light.svg'),
                                    const Text(
                                      'Date',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                  ],
                                ))),
                        SizedBox(
                          width: 100,
                          height: 30,
                          child: TextField(
                            onChanged: (text) {},
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.0)),
                              ),
                              hintText: 'Time',
                              prefixIcon: SvgPicture.asset(
                                  'assets/icons/Time_light.svg'),
                              contentPadding: EdgeInsets.only(top: 7, left: 5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: SizedBox(
                      height: 60,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xffF2F208)),
                        onPressed: () async {
                          if (kDebugMode) {
                            print("Button had been pressed");
                          }
                          Map<String, dynamic> result =
                              await registerNewTicket({
                            "title": title,
                            "description": description,
                            "weight": weight.toString().replaceAll('.', ','),
                            "product_type": type,
                            "reward": reward.toString().replaceAll('.', ',')
                          });
                          await pushFirebaseStorage(result['ticket_id'],
                              pickedFile, currentUser.userId);
                          Navigator.of(context)
                              .pushReplacementNamed('/PageOfActiveOrders');
                        },
                        child: const Text(
                          'Push Order',
                          style: TextStyle(color: Color(0xff000000)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
