import 'package:evogram/presentation/screens/settings_screen/widgets.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';

import '../../../application/core/constants.dart';
import 'about_us_screen/about_us_screen.dart';
import 'privacy_policies/privacy_policy_screen.dart';
import 'terms_and_conditions_screen/terms_and_conditions_screen.dart';
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
          elevation: 1,
          shadowColor: lightgrey,
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
                      navigatePushAnimaterighttoleft(
                          context, const AboutUsScreen());
                    },
                    child: const SettingsTile(
                        leadingIcon: CupertinoIcons.info,
                        text: 'About Us',
                        trailingIcon: Icons.arrow_forward_ios),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigatePushAnimaterighttoleft(
                          context, const PrivacyPolicyScreen());
                    },
                    child: const SettingsTile(
                        text: 'Privacy Policies',
                        leadingIcon: Icons.palette_outlined,
                        trailingIcon: Icons.arrow_forward_ios),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigatePushAnimaterighttoleft(
                          context, const TermsAndConditionsScreen());
                    },
                    child: const SettingsTile(
                        text: 'Terms & Conditions',
                        leadingIcon: Icons.mark_chat_read_outlined,
                        trailingIcon: Icons.arrow_forward_ios),
                  ),
                  GestureDetector(
                    onTap: () {
                      showCustomAlert(context);
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
