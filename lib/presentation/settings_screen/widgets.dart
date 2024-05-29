import 'package:evogram/presentation/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

Future<void> showSignOutAlert(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            const Text(
              textAlign: TextAlign.center,
              'Sign Out',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20),
            ),
            Text(
              textAlign: TextAlign.center,
              'Do you really want to sign out?',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height * .02),
            ),
          ],
        ),
        titlePadding:
            const EdgeInsets.only(top: 40, bottom: 30, right: 10, left: 10),
        actions: [
          OutlinedButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel',
                  style: TextStyle(
                      color: Color.fromARGB(255, 109, 109, 109),
                      fontWeight: FontWeight.bold))),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx2) => const LoginScreen()),
                  (route) => false);
            },
            child: const Text(
              'Sign Out',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
