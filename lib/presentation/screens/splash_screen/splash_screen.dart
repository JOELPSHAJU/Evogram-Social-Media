import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:evogram/presentation/screens/main_screen/main_screen.dart';
import '../../../application/core/constants.dart';
import '../login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final lightbg = "assets/loading.gif";
final darkbg = "assets/loadingdark.gif";

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == Brightness.light ? white : black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? lightbg
                  : darkbg,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  logo2,
                  width: size.width * .4,
                )
                    .animate(delay: 500.milliseconds)
                    .fadeIn(duration: 500.milliseconds)
                    .scale(curve: Curves.fastLinearToSlowEaseIn),
                h20,
                (Theme.of(context).brightness == Brightness.light
                        ? Image.asset(
                            logoletters,
                            width: size.width * .35,
                          )
                        : Image.asset(
                            logoletterswhite,
                            width: size.width * .35,
                          ))
                    .animate(delay: 1000.milliseconds)
                    .fadeIn(duration: 600.milliseconds)
                    .scale(curve: Curves.fastLinearToSlowEaseIn),
                h10,
                LoadingAnimationWidget.prograssiveDots(
                  color: Theme.of(context).brightness == Brightness.light
                      ? black
                      : white,
                  size: 40,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkUserLogin(context) async {
    final preferences = await SharedPreferences.getInstance();
    final userLoggedIn = preferences.get('LOGIN');
    if (userLoggedIn == null || userLoggedIn == false) {
      await Future.delayed(const Duration(seconds: 5));
      navigatePushReplaceAnimaterbottomtotop(context, LoginScreen());
    } else {
      await Future.delayed(const Duration(seconds: 5));
      navigatePushReplaceAnimaterbottomtotop(context, MainScreen());
    }
  }
}
