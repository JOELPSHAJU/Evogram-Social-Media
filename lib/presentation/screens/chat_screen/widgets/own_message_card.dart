import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnMessageCard extends StatelessWidget {
  final String message;
  final DateTime time;
  const OwnMessageCard({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child: Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          color: blueaccent3,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 70, top: 10, bottom: 20),
                child: Text(
                  message,
                  style: const TextStyle(
                      fontSize: 16, color: white, fontWeight: FontWeight.w500),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 5,
                child: Row(
                  children: [
                    Text(
                      DateFormat('h:mm a').format(time.toLocal()),
                      style: TextStyle(fontSize: 13, color: Colors.grey[300]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
