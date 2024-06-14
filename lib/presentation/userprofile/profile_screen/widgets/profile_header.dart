import 'package:evogram/core/constants.dart';
import 'package:evogram/infrastructure/bloc/login_user_bloc/login_user_bloc.dart';
import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:evogram/presentation/followers_screen/followers_screen.dart';
import 'package:evogram/presentation/following_screen/following_screen.dart';
import 'package:evogram/presentation/userprofile/edit_profile/edit_profile.dart';

import 'package:evogram/presentation/userprofile/profile_screen/widgets/profile_styles.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/specific_uploadedpost.dart';

import 'package:evogram/presentation/widgets/custom_navigators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget profileHeaderWidgets(
  BuildContext context,
  LoginUserSucessState state,
  size,
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
                image: NetworkImage(state.users.backGroundImage),
                fit: BoxFit.cover)),
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
                            ? Colors.grey.shade300
                            : black),
                    image: DecorationImage(
                        image: NetworkImage(
                          state.users.profilePic,
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
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          state.users.name.toString(),
          style: profilestyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Text(
          state.users.bio.toString(),
          style: profilestyle2,
        ),
      ),
      h20,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocConsumer<FetchingUserPostBloc, FetchingUserPostState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FetchUserPostLoadingState) {
                return Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: blueaccent2, size: 40));
              } else if (state is FetchUserPostSuccessState) {
                return GestureDetector(
                  onTap: () {
                    navigatePushAnimaterbottomtotop(
                        context,
                        UserPosts(
                          userId: state.userposts[0].userId.id,
                          initialindex: 0,
                        ));
                  },
                  child: Column(
                    children: [
                      Text(
                        state.userposts.length.toString(),
                        style: profilestyle,
                      ),
                      const Text('Posts', style: profilestyle2)
                    ],
                  ),
                );
              }
              return const Center(
                child: Column(
                  children: [
                    Text(
                      '0',
                      style: profilestyle,
                    ),
                    Text('Posts', style: profilestyle2)
                  ],
                ),
              );
            },
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
          GestureDetector(
            onTap: () {
              navigatePushAnimaterbottomtotop(
                  context,
                  EditProfileScreen(
                    loginuser: state.users,
                  ));
            },
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey[300]
                      : darkgreymain,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.normal,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade500
                          : const Color.fromARGB(255, 0, 0, 0),
                      offset: const Offset(6.0, 6.0),
                      blurRadius: 20.0,
                      spreadRadius: 5.0,
                    ),
                    BoxShadow(
                      blurStyle: BlurStyle.normal,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color.fromARGB(255, 0, 0, 0),
                      offset: const Offset(-6.0, -6.0),
                      blurRadius: 20.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                width: size.width * .5,
                height: 45,
                child: Center(
                  child: Text('Edit Profile',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? black
                                  : white,
                          fontSize: 16)),
                )),
          ),
        ],
      ),
      h20,
    ]),
  );
}
