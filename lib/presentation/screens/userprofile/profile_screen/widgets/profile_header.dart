import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/followings_model.dart';
import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_followings_bloc/fetch_followings_bloc.dart';
import 'package:evogram/presentation/bloc/login_user_bloc/login_user_bloc.dart';
import 'package:evogram/presentation/screens/followers_screen/followers_screen.dart';
import 'package:evogram/presentation/screens/following_screen/following_screen.dart';
import 'package:evogram/presentation/screens/userprofile/edit_profile/edit_profile.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/my_post/specific_uploadedpost.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/profile_styles.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
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
                    borderRadius: BorderRadius.circular(100)),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: state.users.profilePic,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return ClipOval(
                        child: Image.asset(
                          profile,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
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
          BlocConsumer<FetchFollowersBloc, FetchFollowersState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FetchFollowersLoadingState) {
                return Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: blueaccent2, size: 40));
              } else if (state is FetchFollowersSuccessState) {
                return GestureDetector(
                    onTap: () {
                      navigatePushAnimaterbottomtotop(
                          context,
                          FollowersScreen(
                            followers: state.followers.followers,
                          ));
                    },
                    child: Column(
                      children: [
                        Text(
                          state.followers.totalCount.toString(),
                          style: profilestyle,
                        ),
                        const Text('Followers', style: profilestyle2)
                      ],
                    ));
              }
              return const Column(
                children: [
                  Text(
                    '0',
                    style: profilestyle,
                  ),
                  Text('Followers', style: profilestyle2)
                ],
              );
            },
          ),
          BlocConsumer<FetchFollowingsBloc, FetchFollowingsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is FetchFollowingsLoadingState) {
                return Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                        color: blueaccent2, size: 40));
              } else if (state is FetchFollowingsSuccesfulState) {
                final FollowingModel followingsModel = state.followingsModel;
                return GestureDetector(
                  onTap: () {
                    navigatePushAnimaterbottomtotop(
                        context,
                        FollowingPersonScreen(
                          model: followingsModel,
                          following: state.followingsModel.following,
                        ));
                  },
                  child: Column(
                    children: [
                      Text(
                        state.followingsModel.totalCount.toString(),
                        style: profilestyle,
                      ),
                      const Text('Following', style: profilestyle2)
                    ],
                  ),
                );
              }
              return const Column(
                children: [
                  Text(
                    '0',
                    style: profilestyle,
                  ),
                  Text('Following', style: profilestyle2)
                ],
              );
            },
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
