import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future PopUpRequestSentNotifier(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/RequestSent.svg',
                  width: 100,
                  height: 100,
                ),
                const Text(
                  'Request sent',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
        );
      });
}
