
import 'package:flutter/material.dart';

void navigatePushandRemoveuntil(BuildContext context, Widget screenMainPage) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => screenMainPage),
    (route) => false,
  );
}
void navigatePush(BuildContext context, Widget screenMainPage) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => screenMainPage),
  );
}