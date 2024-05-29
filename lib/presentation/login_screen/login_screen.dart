import 'package:evogram/infrastructure/bloc/login_bloc/login_bloc.dart';
import 'package:evogram/presentation/widgets/custom_navigators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants.dart';
import '../main_screen/main_screen.dart';
import 'widgets.dart';
import '../register_screen/register_screen.dart';
import '../widgets/snakbars.dart';
import '../widgets/validators.dart';
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
      backgroundColor: white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            navigatePushandRemoveuntil(context, const MainScreen());
            customSnackbar(context, 'Login Successfull', green50);
          } else if (state is LoginErrorStateInvalidPassword) {
            customSnackbar(context, 'Invalid password', red);
          } else if (state is LoginErrorStateUsernotfound) {
            customSnackbar(context, 'user not found', red);
          } else if (state is LoginErrorStateAccountisBlocked) {
            customSnackbar(context, 'Account is blocked', red);
          } else if (state is LoginErrorStateInternalServerError) {
            customSnackbar(context, 'Internal server Error', red);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              width: size.width,
              height: size.height,
              child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          logoletters,
                          width: size.width * .45,
                        ),
                        h30,
                        const Row(
                          children: [Text('Login', style: authheadingstyle)],
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
                        h20,
                        MaterialButton(
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
                                customSnackbar(context, 'Fill All Fields', red);
                              }
                            },
                            child: const Text('Log In',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                    fontSize: 17))),
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
                        h10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              googlelogo,
                              width: 30,
                            ),
                            w10,
                            const Text(
                              'Login with Google',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: darkgrey),
                            )
                          ],
                        ),
                        h10,
                        Container(
                          width: size.width,
                          height: 60,
                          decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: lightgrey)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Dont Have An Account?',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: darkgrey),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => RegisterScreen()));
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
                        ),
                        h10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: grey,
                                      fontSize: 15),
                                ))
                          ],
                        ),
                      ])),
            ),
          );
        },
      ),
    ));
  }
}
