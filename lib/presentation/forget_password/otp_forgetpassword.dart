import 'package:evogram/core/constants.dart';
import 'package:evogram/infrastructure/bloc/forget_password_bloc/forgetpassword_bloc.dart';
import 'package:evogram/presentation/login_screen/login_screen.dart';
import 'package:evogram/presentation/widgets/custom_button.dart';
import 'package:evogram/presentation/widgets/custom_navigators.dart';
import 'package:evogram/presentation/widgets/snakbars.dart';

import 'package:evogram/presentation/widgets/text_styles.dart';
import 'package:evogram/presentation/widgets/textformfield.dart';
import 'package:evogram/presentation/widgets/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpForgetpassword extends StatelessWidget {
  final String email;
  OtpForgetpassword({super.key, required this.email});
  final formkeyreset = GlobalKey<FormState>();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();
  String otp = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<ForgetpasswordBloc, ForgetpasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccesState) {
          navigatePushandRemoveuntil(context, LoginScreen());
        } else if (state is OtpverifiedErrorState) {
          customSnackbar(context, state.error, redlogout);
        } else if (state is ResetPasswordErrorState) {
          customSnackbar(context, state.error, red);
        }
      },
      builder: (context, state) {
        if (state is OtpverifiedSuccesState) {
          return Scaffold(
            body: Container(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                      key: formkeyreset,
                      child: Column(
                        children: [
                          TextformfieldCustom(
                              controller: passwordcontroller,
                              validator: validatePassword,
                              hintText: 'Enter New Password'),
                          TextformfieldCustom(
                              controller: confirmpasswordcontroller,
                              validator: validatePassword,
                              hintText: 'Confirm Password')
                        ],
                      )),
                  BlocBuilder<ForgetpasswordBloc, ForgetpasswordState>(
                    builder: (context, state) {
                      if (state is ForgetpasswordLoadingState) {
                        return loadingButton(
                            media: size, onPressed: () {}, color: blue);
                      }
                      return BlocBuilder<ForgetpasswordBloc,
                          ForgetpasswordState>(
                        builder: (context, state) {
                          if (state is ResetpasswordLoadingState) {
                            return loadingButton(
                                media: size,
                                onPressed: () {},
                                color: redlogout);
                          }
                          return MaterialButton(
                              color: blue,
                              minWidth: size.width,
                              height: 55,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: () {
                                if (formkeyreset.currentState!.validate()) {
                                  print(otp);
                                  print(email);
                                  print('dsfsdf');
                                  context.read<ForgetpasswordBloc>().add(
                                      OnResetPasswordButtonClickedEvent(
                                          email: email,
                                          password: passwordcontroller.text));
                                  print('After context');
                                } else {
                                  customSnackbar(
                                      context, 'Fill The Field', redlogout);
                                }
                                print('test');
                              },
                              child: const Text('Continue',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: white,
                                      fontSize: 17)));
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
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
                          color:
                              Theme.of(context).brightness == Brightness.light
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
                      BlocBuilder<ForgetpasswordBloc, ForgetpasswordState>(
                        builder: (context, state) {
                          if (state is OtpverifiedLoadingState) {
                            loadingButton(
                                media: size,
                                onPressed: () {},
                                color: redlogout);
                          }
                          return MaterialButton(
                              color: blue,
                              minWidth: size.width * .4,
                              height: 55,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              onPressed: () {
                                if (otp.length < 4 || otp.isEmpty) {
                                  customSnackbar(
                                      context, 'Inavlid Otp', redlogout);
                                }
                                context.read<ForgetpasswordBloc>().add(
                                    OnVerifyButtonClickedEvent(
                                        email: email, otp: otp));
                              },
                              child: const Text('Verify',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: white,
                                      fontSize: 17)));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
