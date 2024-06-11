// ignore_for_file: unused_element, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'package:evogram/core/constants.dart';
import 'package:evogram/presentation/login_screen/login_screen.dart';
import 'package:evogram/presentation/widgets/snakbars.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showCustomAlert(BuildContext context) {
  QuickAlert.show(
    backgroundColor:
        Theme.of(context).brightness == Brightness.light ? white : darkbg,
    context: context,
    confirmBtnText: 'Signout',
    confirmBtnColor: black,
    type: QuickAlertType.custom,
    showCancelBtn: true,
    customAsset: Theme.of(context).brightness == Brightness.light
        ? 'assets/alertbg.jpg'
        : 'assets/alertbgblk.jpg',
    widget: const Column(
      children: [
        Text(
          "Sign Out?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          textAlign: TextAlign.center,
          "Are you sure? Do you really want to Sign Out.",
          style: TextStyle(fontSize: 16),
        ),
      ],
    ),
    onCancelBtnTap: () {
      Navigator.pop(context, false);
    },
    onConfirmBtnTap: () async {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      Future<void> signOut() async {
        try {
          await _googleSignIn.signOut();
          customSnackbar(
              context, 'User signed out from Google account', green50);
        } catch (error) {
          customSnackbar(context, "Error signing out: $error", redlogout);
        }
      }

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('LOGIN', false);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx2) => const LoginScreen()),
          (route) => false);
    },
  );
}
