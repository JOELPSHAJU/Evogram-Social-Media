import 'package:evogram/core/constants.dart';
import 'package:evogram/presentation/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showSignOutAlert(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor:
            Theme.of(context).brightness == Brightness.light ? white : darkgrey,
        title: Column(
          children: [
            w10,
            Center(
              child: Text(
                textAlign: TextAlign.center,
                'Sign Out',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                        ? redlogout
                        : redlogout,
                    fontSize: 20),
              ),
            ),
            h10,
            Text(
              textAlign: TextAlign.center,
              'Do you really want to sign out?',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).brightness == Brightness.light
                      ? black
                      : darkgreymain,
                  fontSize: MediaQuery.of(context).size.height * .02),
            ),
          ],
        ),
        titlePadding:
            const EdgeInsets.only(top: 40, bottom: 30, right: 10, left: 10),
        actions: [
          OutlinedButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: Text('Cancel',
                  style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? grey
                          : darkgreymain,
                      fontWeight: FontWeight.bold))),
          OutlinedButton(
            onPressed: ()async {
                SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool('LOGIN', false);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx2) => const LoginScreen()),
                  (route) => false);
            },
            child: Text(
              'Sign Out',
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.light
                      ? redlogout
                      : redlogout,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
