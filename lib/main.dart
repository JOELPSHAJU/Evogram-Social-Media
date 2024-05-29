import 'package:evogram/infrastructure/bloc/login_bloc/login_bloc.dart';
import 'package:evogram/infrastructure/bloc/otp_bloc/bloc/otp_bloc.dart';
import 'package:evogram/infrastructure/bloc/signup_bloc/signup_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/splash_screen/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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

      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        theme: ThemeData(
            fontFamily: GoogleFonts.inter().fontFamily,
            textTheme: const TextTheme(
                bodyLarge: TextStyle(),
                bodyMedium: TextStyle(),
                bodySmall: TextStyle())),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
