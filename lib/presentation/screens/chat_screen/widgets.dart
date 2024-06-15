import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateDivider extends StatelessWidget {
  final DateTime date;

  const DateDivider({required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isToday = date.year == now.year && date.month == now.month && date.day == now.day;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        isToday? 'Today' : DateFormat.yMMMd().format(date),
        style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }
}