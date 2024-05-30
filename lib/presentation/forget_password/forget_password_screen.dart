import 'package:evogram/presentation/widgets/textformfield.dart';
import 'package:flutter/widgets.dart';

import '../../core/constants.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  logo2,
                  width: size.width * .3,
                ),
                h10,
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: size.width * .06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                h10,
                const Text(
                  textAlign: TextAlign.center,
                  'Enter your email address and we will send you\nan otp to reset your password.',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: darkgrey),
                ),
                h30,
                TextformfieldCustom(
                    controller: emailController, hintText: 'Email Address'),
                h30,
                MaterialButton(
                    color: blue,
                    minWidth: size.width,
                    height: 55,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {},
                    child: const Text('Continued',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: white,
                            fontSize: 17))),
                h20,
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Back to Login',
                      style: const TextStyle(
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                          decorationColor: blue,
                          fontWeight: FontWeight.w600,
                          color: blue),
                    ))
              ]),
        ),
      ),
    );
  }
}
