import 'package:evogram/core/constants.dart';
import 'package:flutter/material.dart';

Widget shimmerWidgetpost(Size media, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).brightness == Brightness.light
                      ? lightgreyauth
                      : black),
              height: media.height * 0.08,
              width: media.height * 0.08,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).brightness == Brightness.light
                          ? lightgreyauth
                          : black),
                  width: media.width * 0.5,
                  height: 10,
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).brightness == Brightness.light
                          ? lightgreyauth
                          : black),
                  width: media.width * 0.3,
                  height: 10,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).brightness == Brightness.light
                  ? lightgreyauth
                  : black),
          width: media.width,
          height: media.width * 0.5,
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).brightness == Brightness.light
                  ? lightgreyauth
                  : black),
          width: media.width * 0.7,
          height: 10,
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).brightness == Brightness.light
                  ? lightgreyauth
                  : black),
          width: media.width * 0.9,
          height: 10,
        ),
      ],
    ),
  );
}
