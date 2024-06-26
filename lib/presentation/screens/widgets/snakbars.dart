import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';

void customSnackbar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 0,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: color,
      duration: const Duration(milliseconds: 1200),
    ),
  );
}

void successSnakbar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 3,
      content: Column(
        children: [
          Image.asset(
            successimg,
            width: 50,
          ),
          Text(
            'Success',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor:
          Theme.of(context).brightness == Brightness.light ? grey300 : darkbg,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

void failedSnakbar(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 3,
      content: Column(
        children: [
          Image.asset(
            fialedimg,
            width: 50,
          ),
          Text(
            'Error',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor:
          Theme.of(context).brightness == Brightness.light ? grey300 : darkbg,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

void warningSnakbar(context, message, color) {
  final Size size = MediaQuery.of(context).size;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      elevation: 7,
      content: Column(
        children: [
          Image.asset(
            warningimg,
            width: 50,
          ),
          Text(
            'Warning',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            message,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      backgroundColor:
          Theme.of(context).brightness == Brightness.light ? grey300 : darkbg,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}
