import 'package:evogram/core/constants.dart';
import 'package:evogram/presentation/edit_profile/edit_profile.dart';
import 'package:evogram/presentation/followers_screen/followers_screen.dart';
import 'package:evogram/presentation/following_screen/following_screen.dart';
import 'package:evogram/presentation/profile_screen/widgets/profile_styles.dart';
import 'package:evogram/presentation/user_posts/user_post.dart';
import 'package:evogram/presentation/widgets/custom_navigators.dart';
import 'package:flutter/material.dart';

Widget profileHeaderWidgets(
  BuildContext context,
  size,
  coverpic,
  profilepic,
) {
  return SizedBox(
    width: double.infinity,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 210,
        width: size.width,
        decoration: BoxDecoration(
            color: blueaccent,
            image: DecorationImage(
                image: NetworkImage(coverpic), fit: BoxFit.cover)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -60,
              left: 20,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 5,
                        color: Theme.of(context).brightness == Brightness.light
                            ? white
                            : darkgreymain),
                    image: DecorationImage(
                        image: NetworkImage(
                          profilepic,
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
          ],
        ),
      ),
      h40,
      h30,
      const Padding(
        padding: EdgeInsets.only(left: 20.0),
        child: Text(
          'Ken Block',
          style: profilestyle,
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20),
        child: Text(
          'I Live my life a quarter mile at a time,if you are ten seconds or less im free',
          style: profilestyle2,
        ),
      ),
      h20,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              navigatePushAnimaterbottomtotop(context, UserPostScreen());
            },
            child: const Column(
              children: [
                Text(
                  '13',
                  style: profilestyle,
                ),
                Text('Posts', style: profilestyle2)
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              navigatePushAnimaterbottomtotop(context, FollowersScreen());
            },
            child: const Column(
              children: [
                Text(
                  '200',
                  style: profilestyle,
                ),
                Text('Followers', style: profilestyle2)
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              navigatePushAnimaterbottomtotop(context, FollowingPersonScreen());
            },
            child: const Column(
              children: [
                Text(
                  '354',
                  style: profilestyle,
                ),
                Text('Following', style: profilestyle2)
              ],
            ),
          ),
        ],
      ),
      h20,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
              color: blueaccent3,
              minWidth: size.width * .5,
              height: 45,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: () {
                navigatePushAnimaterbottomtotop(context, EditProfileScreen());
              },
              child: const Text('Edit Profile',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: white,
                      fontSize: 16))),
        ],
      ),
      h20,
    ]),
  );
}
