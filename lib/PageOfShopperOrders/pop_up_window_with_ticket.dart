import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../main.dart';

Future popUpTicket(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return const Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Text('In development'),
          ),
        ),
      );
    },
  );
}
