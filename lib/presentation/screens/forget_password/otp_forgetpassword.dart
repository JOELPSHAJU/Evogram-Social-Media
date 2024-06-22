// ignore_for_file: must_be_immutable

import 'package:evogram/application/core/constants.dart';
import 'package:evogram/presentation/bloc/forget_password_bloc/forgetpassword_bloc.dart';

import 'package:evogram/presentation/screens/login_screen/login_screen.dart';
import 'package:evogram/presentation/screens/widgets/custom_button.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:evogram/presentation/screens/widgets/snakbars.dart';

import 'package:evogram/presentation/screens/widgets/text_styles.dart';
import 'package:evogram/presentation/screens/widgets/textformfield.dart';
import 'package:evogram/presentation/screens/widgets/validators.dart';
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
          navigatePushandRemoveuntil(context, const LoginScreen());
        } else if (state is OtpverifiedErrorState) {
          customSnackbar(context, state.error, redlogout);
        } else if (state is ResetPasswordErrorState) {
          customSnackbar(context, state.error, red);
        }
      },
      builder: (context, state) {
        if (state is OtpverifiedSuccesState) {
          return Scaffold(
            backgroundColor: Theme.of(context).brightness == Brightness.light
                ? white
                : black,
            body: SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      logo2,
                      width: size.width * .3,
                    ),
                    h10,
                    const Text(
                      'Set your New Password',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    h10,
                    const Text(
                      textAlign: TextAlign.center,
                      'Once you reset your password, You can login to your account using that password',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: grey),
                    ),
                    h10,
                    Form(
                        key: formkeyreset,
                        child: Column(
                          children: [
                            TextformfieldCustom(
                                controller: passwordcontroller,
                                validator: validatePassword,
                                hintText: 'Enter New Password'),
                            h10,
                            TextformfieldCustom(
                                controller: confirmpasswordcontroller,
                                validator: validatePassword,
                                hintText: 'Confirm Password')
                          ],
                        )),
                    h20,
                    BlocBuilder<ForgetpasswordBloc, ForgetpasswordState>(
                      builder: (context, state) {
                        if (state is ForgetpasswordLoadingState) {
                          return loadingButton(
                              media: size, onPressed: () {}, color: buttonclr);
                        }
                        return BlocBuilder<ForgetpasswordBloc,
                            ForgetpasswordState>(
                          builder: (context, state) {
                            if (state is ResetpasswordLoadingState) {
                              return loadingButton(
                                  media: size,
                                  onPressed: () {},
                                  color: buttonclr);
                            }
                            return MaterialButton(
                                color: buttonclr,
                                minWidth: size.width,
                                height: 55,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                onPressed: () {
                                  if (formkeyreset.currentState!.validate()) {
                                    context.read<ForgetpasswordBloc>().add(
                                        OnResetPasswordButtonClickedEvent(
                                            email: email,
                                            password: passwordcontroller.text));
                                  } else {
                                    customSnackbar(
                                        context, 'Fill The Field', redlogout);
                                  }
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
            ),
          );
        }
        return Scaffold(
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
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
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10),
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
                    enabledBorderColor: buttonclr,
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
                                color: buttonclr);
                          }
                          return MaterialButton(
                              color: buttonclr,
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
