import 'package:evogram/core/constants.dart';

import 'package:evogram/presentation/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpForgetpassword extends StatelessWidget {
  OtpForgetpassword({super.key});

  String otp = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                otpsent,
                width: 130,
              ),
              h10,
              appbarTitle(title: 'Please check your Email'),
              h10,
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),
              h40,
              OtpTextField(
                fieldWidth: 60,
                fieldHeight: 70,
                numberOfFields: 4,
                borderColor: grey,
                enabledBorderColor: blue,
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  otp = verificationCode;
                },
              ),
              h40,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      color: Theme.of(context).brightness == Brightness.light
                          ? white
                          : grey,
                      minWidth: size.width * .4,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: black),
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? darkgrey
                                  : white,
                              fontSize: 17))),
                  MaterialButton(
                      color: blue,
                      minWidth: size.width * .4,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {},
                      child: const Text('Verify',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: white,
                              fontSize: 17))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
