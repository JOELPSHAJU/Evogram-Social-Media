import 'package:evogram/application/core/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          shadowColor:
              Theme.of(context).brightness == Brightness.light ? white : grey80,
          elevation: 30,
          backgroundColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          surfaceTintColor:
              Theme.of(context).brightness == Brightness.light ? white : black,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
          title: appbarTitle(title: 'About Us'),
        ),
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  h10,
                  RichText(
                    text: TextSpan(
                      text: 'Welcome to Evogram',
                      style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? black
                                  : lightgrey),
                    ),
                  ),
                  h10,
                  RichText(
                    text: TextSpan(
                      text:
                          'The ultimate social media platform designed to make every connection vibrant and meaningful. At Evogram, we believe in the power of communication and the magic of keeping relationships alive through seamless digital interaction',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? grey
                                  : grey),
                    ),
                  ),
                  h10,
                  RichText(
                    text: TextSpan(
                      text: 'Features',
                      style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? black
                                  : lightgrey),
                    ),
                  ),
                  h10,
                  RichText(
                    text: TextSpan(
                        text: 'Post & Share: ',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? black
                                    : lightgrey),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                ' Dive into a seamless experience where you can post your thoughts, share your moments, and express yourself freely. Evogram lets you share your world effortlessly',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: grey),
                          ),
                        ]),
                  ),
                  h10,
                  RichText(
                    text: TextSpan(
                        text: 'Edit & Delete Posts: ',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? black
                                    : lightgrey),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Take full control over your content. Changed your mind? Edit or delete your posts anytime to keep your profile exactly how you want it.',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? grey
                                  : grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ]),
                  ),
                  h10,
                  RichText(
                    text: TextSpan(
                        text: 'Post & Share: ',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? black
                                    : lightgrey),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                ' Dive into a seamless experience where you can post your thoughts, share your moments, and express yourself freely. Whether it’s a photo, video, or text, Evogram lets you share your world effortlessly',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: grey),
                          ),
                        ]),
                  ),
                  h10,
                  RichText(
                    text: TextSpan(
                        text: 'Engage with Content: ',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? black
                                    : lightgrey),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Show your appreciation by liking and commenting on posts. Engage in lively discussions, share your opinions, and connect with others in a meaningful way.',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: grey),
                          ),
                        ]),
                  ),
                  h10,
                  RichText(
                    text: TextSpan(
                        text: 'Follow/Unfollow: ',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? black
                                    : lightgrey),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Build your network by following friends, family, and influencers. Customize your feed by choosing whom to follow while also having the flexibility to unfollow at any time.',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: grey),
                          ),
                        ]),
                  ),
                  h10,
                  RichText(
                    text: TextSpan(
                        text: 'Private Messaging: ',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? black
                                    : lightgrey),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                "Stay connected with friends and family through our robust private messaging feature. Whether it's a quick chat or an in-depth conversation, Evogram ensures you stay close to your loved ones no matter the distance.",
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: grey),
                          ),
                        ]),
                  ),
                  h10,
                  RichText(
                    text: TextSpan(
                        text: 'Customizable Profiles',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? black
                                    : lightgrey),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                ' : Personalize your profile with a variety of customization options. Show off your unique personality and make your profile stand out.',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: grey),
                          ),
                        ]),
                  ),
                  h10,
                  RichText(
                    text: TextSpan(
                        text: 'Privacy Controls',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? black
                                    : lightgrey),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                ' : Manage your privacy with ease. Control who sees your content, who can contact you, and who can follow you with our comprehensive privacy settings.',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: grey),
                          ),
                        ]),
                  ),
                  h10,
                  Text(
                    'At Evogram, we are dedicated to creating a platform that not only entertains but also fosters genuine connections and community building. Join us to experience a world where every interaction matters and every connection is cherished. Welcome to Evogram – where your digital life thrives.',
                    style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).brightness == Brightness.light
                            ? grey
                            : grey),
                  ),
                  h30,
                  Theme.of(context).brightness == Brightness.light
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              logo2,
                              width: size.width * .15,
                            ),
                            w10,
                            Image.asset(
                              logoletters,
                              width: size.width * .3,
                            )
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              logo2,
                              width: size.width * .15,
                            ),
                            w10,
                            Image.asset(
                              logoletterswhite,
                              width: size.width * .3,
                            )
                          ],
                        ),
                  h40,
                  h10
                ],
              ),
            ),
          ),
        ));
  }
}
