import 'package:evogram/application/core/constants.dart';
import 'package:evogram/presentation/screens/suggessions_screen/suggession_screen.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Richtext extends StatelessWidget {
  const Richtext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        const TextSpan(
            text: 'Go to  ',
            style: TextStyle(
                color: black,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                fontSize: 15)),
        TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigatePushAnimaterbottomtotop(
                    context, const SuggessionScreen());
              },
            text: 'Suggessions?',
            style: const TextStyle(
                color: blue,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                fontSize: 15))
      ]),
    );
  }
}
