import 'package:evogram/presentation/main_screen/main_screen.dart';

import '../../../core/constants.dart';

import '../login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == Brightness.light ? white : black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              logo2,
              width: size.width * .4,
            ),
            h20,
            Theme.of(context).brightness == Brightness.light
                ? Image.asset(
                    logoletters,
                    width: size.width * .35,
                  )
                : Image.asset(
                    logoletterswhite,
                    width: size.width * .35,
                  ),
            h10,
            LoadingAnimationWidget.prograssiveDots(
              color: Theme.of(context).brightness == Brightness.light
                  ? black
                  : darkgrey,
              size: 40,
            )
          ],
        ),
      ),
    );
  }

  Future<void> checkUserLogin(context) async {
    final preferences = await SharedPreferences.getInstance();
    final userLoggedIn = preferences.get('LOGIN');
    if (userLoggedIn == null || userLoggedIn == false) {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ));
    }
  }
}
