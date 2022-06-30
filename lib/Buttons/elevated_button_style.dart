import 'package:flutter/material.dart';

ButtonStyle roundedWhite = ElevatedButton.styleFrom(
  primary: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  elevation: 0,
  side: const BorderSide(color: Colors.black),
);

class TextAndArrowButtonChild extends StatelessWidget {
  final String buttonText;
  const TextAndArrowButtonChild({Key? key, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        buttonText,
        style: const TextStyle(fontSize: 14, color: Colors.black),
      ),
      const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
        size: 14,
      ),
    ]);
  }
}
