import 'package:evogram/infrastructure/bloc/forget_password_bloc/forgetpassword_bloc.dart';
import 'package:evogram/presentation/forget_password/otp_forgetpassword.dart';
import 'package:evogram/presentation/widgets/custom_button.dart';
import 'package:evogram/presentation/widgets/custom_navigators.dart';
import 'package:evogram/presentation/widgets/snakbars.dart';
import 'package:evogram/presentation/widgets/textformfield.dart';
import 'package:evogram/presentation/widgets/validators.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final emailController = TextEditingController();
  final forgetpasswordkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<ForgetpasswordBloc, ForgetpasswordState>(
      listener: (context, state) {
        if (state is ForgetpasswordSucessState) {
          navigatePushAnimaterighttoleft(
              context,
              OtpForgetpassword(
                email: emailController.text,
              ));
        } else if (state is ForgetpasswordErrorState) {
          customSnackbar(context, state.error, redlogout);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          body: Container(
            color: Theme.of(context).brightness == Brightness.light
                ? white
                : black,
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
                    Form(
                      key: forgetpasswordkey,
                      child: TextformfieldCustom(
                          controller: emailController,
                          validator: validateEmail,
                          hintText: 'Email Address'),
                    ),
                    h30,
                    BlocBuilder<ForgetpasswordBloc, ForgetpasswordState>(
                      builder: (context, state) {
                        if (state is ForgetpasswordLoadingState) {
                          return loadingButton(
                              media: size, onPressed: () {}, color: blue);
                        }
                        return MaterialButton(
                            color: blue,
                            minWidth: size.width,
                            height: 55,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              if (forgetpasswordkey.currentState!.validate()) {
                                context.read<ForgetpasswordBloc>().add(
                                    ForgetPasswordButtonClicked(
                                        email: emailController.text));
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
                    ),
                    h20,
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Back to Login',
                          style: TextStyle(
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
      },
    );
  }
}
