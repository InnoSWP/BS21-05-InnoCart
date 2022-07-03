import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future popUpOrderCanceled(BuildContext context) {
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
                  'assets/icons/close_ring_light.svg',
                  width: 100,
                  height: 100,
                ),
                const Text(
                  'Order canceled',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
        );
      });
}
