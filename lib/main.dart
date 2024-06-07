import 'package:evogram/core/constants.dart';
import 'package:evogram/firebase_options.dart';
import 'package:evogram/infrastructure/bloc/add_post_bloc/addpost_bloc.dart';
import 'package:evogram/infrastructure/bloc/forget_password_bloc/forgetpassword_bloc.dart';
import 'package:evogram/infrastructure/bloc/login_bloc/login_bloc.dart';
import 'package:evogram/infrastructure/bloc/otp_bloc/bloc/otp_bloc.dart';
import 'package:evogram/infrastructure/bloc/signup_bloc/signup_bloc.dart';
import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:evogram/presentation/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => OtpBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => ForgetpasswordBloc(),
        ),
        BlocProvider(
          create: (context) => AddpostBloc(),
        ),
        BlocProvider(
          create: (context) => FetchingUserPostBloc(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        themeMode: ThemeMode.system,
        theme: ThemeData(
            tabBarTheme: const TabBarTheme(
                overlayColor: WidgetStatePropertyAll(
              white,
            )),
            brightness: Brightness.light,
            scaffoldBackgroundColor: white,
            appBarTheme: const AppBarTheme(
              color: white,
              iconTheme: IconThemeData(
                color: black,
              ),
              surfaceTintColor: white,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 20, color: black),
            ),
            primaryColor: blueaccent3,
            fontFamily: GoogleFonts.inter().fontFamily,
            textTheme: const TextTheme(
                bodyLarge: TextStyle(),
                bodyMedium: TextStyle(),
                bodySmall: TextStyle())),
        darkTheme: ThemeData.dark(),
        /* dark theme settings */

        // ThemeData(
        //    ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
