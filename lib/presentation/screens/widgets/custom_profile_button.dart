import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';

class CustomProfileButton extends StatelessWidget {
  const CustomProfileButton({
    super.key,
    required this.size,
    required this.text,
    required this.width,
  });

  final Size size;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey[300]
              : black,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.normal,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade500
                  : Colors.transparent,
              offset: const Offset(6.0, 6.0),
              blurRadius: 20.0,
              spreadRadius: 5.0,
            ),
            BoxShadow(
              blurStyle: BlurStyle.normal,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.transparent,
              offset: const Offset(-6.0, -6.0),
              blurRadius: 20.0,
              spreadRadius: 5.0,
            ),
          ],
        ),
        width: size.width * width,
        height: 45,
        child: Center(
          child: Text(text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.light
                      ? black
                      : white,
                  fontSize: 16)),
        ));
  }
}
