// ignore_for_file: avoid_print

import 'package:evogram/infrastructure/bloc/login_bloc/login_bloc.dart';
import 'package:evogram/presentation/authentication/forget_password/forget_password_screen.dart';
import 'package:evogram/presentation/main_screen/main_screen.dart';
import 'package:evogram/presentation/widgets/custom_button.dart';
import 'package:evogram/presentation/widgets/snakbars.dart';
import 'package:evogram/presentation/widgets/validators.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants.dart';

import 'widgets.dart';
import '../register_screen/register_screen.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginbloc = context.read<LoginBloc>();
    return SafeArea(
        child: Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            customSnackbar(context, 'welcome back', green50);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) {
                return const MainScreen();
              }),
              (Route<dynamic> route) => false,
            );
          } else if (state is LoginErrorState) {
            customSnackbar(context, state.error, red);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Row(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30),
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
                                Text('Login',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? black
                                            : white))
                              ],
                            ),
                            h20,
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormFieldAuth(
                                    validator: validateEmail,
                                    controller: usernameController,
                                    hintText: 'Email',
                                  ),
                                  h20,
                                  TextFormFieldPassword(
                                    validator: validatePassword,
                                    controller: passwordController,
                                    hintText: 'Password',
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      gotoForgetPassword();
                                    },
                                    child: const Text(
                                      'Forget Password?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: blue,
                                          fontSize: 15),
                                    ))
                              ],
                            ),
                            BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state is LoginLoadingstate) {
                                  return loadingButton(
                                      media: size,
                                      onPressed: () {},
                                      color: blue);
                                }
                                return MaterialButton(
                                    color: blue,
                                    minWidth: size.width,
                                    height: 55,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        loginbloc.add(LoginButtonClickEvent(
                                            email: usernameController.text,
                                            password: passwordController.text));
                                      } else {
                                        customSnackbar(
                                            context, 'Fill All Fields', red);
                                      }
                                    },
                                    child: const Text('Log In',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: white,
                                            fontSize: 17)));
                              },
                            ),
                            h20,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'or',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: grey,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                            h20,
                            Container(
                              width: size.width,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? white
                                      : darkgreymain,
                                  border: Border.all(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? lightgrey
                                          : darkgrey)),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<LoginBloc>()
                                      .add(GoogleLoginButtonClickEvent());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      googlelogo,
                                      width: 30,
                                    ),
                                    w10,
                                    Text(
                                      'Login with Google',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? darkgrey
                                              : grey),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            h20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Dont Have An Account?',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? darkgrey
                                          : grey),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                const RegisterScreen()));
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: blue),
                                  ),
                                )
                              ],
                            ),
                          ])),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }

  gotoForgetPassword() {
    return Navigator.of(context).push(
        MaterialPageRoute(builder: (forgetpassword) => ForgetPasswordScreen()));
  }
}
