import 'package:evogram/application/models/signup_model.dart';
import 'package:evogram/infrastructure/bloc/signup_bloc/signup_bloc.dart';
import 'package:evogram/presentation/login_screen/login_screen.dart';
import 'package:evogram/presentation/register_screen/widgets.dart';
import 'package:evogram/presentation/widgets/custom_button.dart';
import 'package:evogram/presentation/widgets/custom_navigators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';



import '../../otp_sent_screen/otp_screen.dart';
import '../../widgets/snakbars.dart';
import '../../widgets/validators.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirPasswordController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final emailAddressController = TextEditingController();

  final formKeyRegister = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserModel? userdetails;
    final size = MediaQuery.of(context).size;
    final signupbloc = context.read<SignupBloc>();
    return SafeArea(
        child: Scaffold(
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            navigatePushandRemoveuntil(
              context,
              OtpScreen(
                email: emailAddressController.text,
                user: userdetails!,
              ),
            );
            customSnackbar(context, 'Otp send Successfully', green50);
          } else if (state is SignupErrorStateAlreadyAccount) {
            customSnackbar(context, 'Already have an Account', red);
          } else if (state is SignupErrorStateUsernamealreadyUsed) {
            customSnackbar(context, 'Already have an Same Username', red);
          } else if (state is SignupErrorStateOtpalreadySent) {
            customSnackbar(context, 'Already otp sent', red);
          } else if (state is SignupErrorStateInternalServerError) {
            customSnackbar(context, 'Internal server error', red);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Theme.of(context).brightness == Brightness.light
                        ? Image.asset(
                            logoletters,
                            width: size.width * .45,
                          )
                        : Image.asset(
                            logoletterswhite,
                            width: size.width * .45,
                          ),
                    h30,
                    Row(
                      children: [
                        Text('Register',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? black
                                    : white))
                      ],
                    ),
                    h10,
                    Form(
                      key: formKeyRegister,
                      child: Column(
                        children: [
                          TextFormFieldAuthRegister(
                              keyboard: TextInputType.name,
                              validator: validateUsername,
                              controller: usernameController,
                              hintText: 'Username'),
                          h10,
                          TextFormFieldAuthRegister(
                              keyboard: TextInputType.emailAddress,
                              controller: emailAddressController,
                              validator: validateEmail,
                              hintText: 'Email Address'),
                          h10,
                          TextFormFieldAuthRegister(
                              validator: validateMobileNumber,
                              keyboard: TextInputType.phone,
                              controller: phoneNumberController,
                              hintText: 'Phone Number'),
                          h10,
                          TextFormFieldPasswordRegister(
                              validator: validatePassword,
                              controller: passwordController,
                              hintText: 'Password'),
                          h10,
                          TextFormFieldPasswordRegister(
                              validator: validatePassword,
                              controller: confirPasswordController,
                              hintText: 'Confirm Password'),
                        ],
                      ),
                    ),
                    h20,
                    BlocBuilder<SignupBloc, SignupState>(
                      builder: (context, state) {
                        if (state is SignupLoadingState) {
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
                              if (formKeyRegister.currentState!.validate()) {
                                final user = UserModel(
                                    email: emailAddressController.text,
                                    userName: usernameController.text,
                                    phone: phoneNumberController.text,
                                    password: passwordController.text);
                                userdetails = user;

                                signupbloc
                                    .add(SignupButtenClickEvent(user: user));
                              } else {
                                customSnackbar(context, 'fill all fields', red);
                              }
                            },
                            child: const Text('Register',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                    fontSize: 17)));
                      },
                    ),
                    h20,
                    Container(
                      width: size.width,
                      height: 60,
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? white
                                  : darkgreymain,
                          border: Border.all(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? lightgrey
                                  : darkgrey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Already Have An Account?',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? darkgrey
                                    : lightgrey),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const LoginScreen()));
                            },
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: blue),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
