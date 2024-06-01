import 'dart:async';

import 'package:evogram/application/models/signup_model.dart';
import 'package:evogram/infrastructure/bloc/otp_bloc/bloc/otp_bloc.dart';
import 'package:evogram/infrastructure/bloc/signup_bloc/signup_bloc.dart';
import 'package:evogram/presentation/login_screen/login_screen.dart';
import 'package:evogram/presentation/widgets/snakbars.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants.dart';

import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final UserModel user;
  const OtpScreen({super.key, required this.email, required this.user});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late Timer _timer;
  Timer? _debounceTimer;
  String otp = '';
  int _start = 60;
  bool _isResendVisible = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _debounceTimer?.cancel();

    super.dispose();
  }

  void startTimer() {
    _isResendVisible = false;
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendVisible = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void debounceResendOtp() {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final otpbloc = context.read<OtpBloc>();
    final signupbloc = context.read<SignupBloc>();
    final Size size = MediaQuery.of(context).size;
    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is OtpSuccessState) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false);
        } else if (state is OtpErrorStateInvalidOtp) {
          customSnackbar(context, 'Invalid otp', red);
        } else if (state is OtpErrorStateInternalServerError) {
          customSnackbar(context, 'Internal server error', red);
        }
      },
      builder: (context, state) {
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
                      children: [
                        const Text(
                          "We've sent a code to",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: darkgrey),
                        ),
                        Text(
                          widget.email,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? black
                                  : white),
                        ),
                      ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't get the code?",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: darkgrey),
                      ),
                      _isResendVisible
                          ? TextButton(
                              onPressed: () {
                                debounceResendOtp;
                                signupbloc.add(
                                    SignupButtenClickEvent(user: widget.user));
                              },
                              child: const Text("Click to resent.",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: blue,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: blue)),
                            )
                          : RichText(
                              text: TextSpan(
                                  text: ' Resend OTP in',
                                  style: const TextStyle(
                                      fontSize: 17, color: darkgrey),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ' $_start ',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        color: blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: 'seconds',
                                      style: TextStyle(
                                          fontSize: 17, color: darkgrey),
                                    ),
                                  ]),
                            )
                    ],
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
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (cts) => LoginScreen()));
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
                          onPressed: () {
                            if (otp.isNotEmpty) {
                              otpbloc.add(OtpverifyClickevent(
                                  email: widget.email, otp: otp));
                            } else {
                              customSnackbar(context, 'please enter otp', red);
                            }
                          },
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
      },
    );
  }
}
