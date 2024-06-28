// ignore_for_file: non_constant_identifier_names

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

void navigatePushAnimaterighttoleft(BuildContext context, Widget Nextscreen) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Nextscreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ));
}

void navigatePushAnimaterbottomtotop(BuildContext context, Widget screen) {
  Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ));
}

void navigatePushReplaceAnimaterbottomtotop(
    BuildContext context, Widget screen) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}
