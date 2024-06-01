import 'package:evogram/presentation/settings_screen/widgets.dart';

import '../../core/constants.dart';
import '../about_us_screen/about_us_screen.dart';
import '../privacy_policies/privacy_policy_screen.dart';
import '../terms_and_conditions_screen/terms_and_conditions_screen.dart';
import '../widgets/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          surfaceTintColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          title: appbarTitle(title: 'Settings and activity'),
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Account',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  h20,
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const AboutUsScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ));
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const AboutUsScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ));
                      },
                      child: const SettingsTile(
                          leadingIcon: CupertinoIcons.info,
                          text: 'About Us',
                          trailingIcon: Icons.arrow_forward_ios),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const PrivacyPolicyScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ));
                    },
                    child: const SettingsTile(
                        text: 'Privacy Policies',
                        leadingIcon: Icons.palette_outlined,
                        trailingIcon: Icons.arrow_forward_ios),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const TermsAndConditionsScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      ));
                    },
                    child: const SettingsTile(
                        text: 'Terms & Conditions',
                        leadingIcon: Icons.mark_chat_read_outlined,
                        trailingIcon: Icons.arrow_forward_ios),
                  ),
                  GestureDetector(
                    onTap: () {
                      showSignOutAlert(context);
                    },
                    child: const SettingsTile(
                        text: 'Logout',
                        leadingIcon: Icons.exit_to_app_outlined,
                        trailingIcon: Icons.arrow_forward_ios),
                  ),
                ],
              ),
              const Spacer(),
              const Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 14, color: grey),
              ),
              h30
            ],
          ),
        ));
  }
}

class SettingsTile extends StatelessWidget {
  final String text;
  final IconData leadingIcon;
  final IconData trailingIcon;
  const SettingsTile({
    super.key,
    required this.text,
    required this.leadingIcon,
    required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Icon(
            leadingIcon,
            size: 25,
            weight: 2,
          ),
          w10,
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Icon(
            trailingIcon,
            size: 25,
            weight: 3,
          )
        ],
      ),
    );
  }
}
