import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/followings_model.dart';
import 'package:evogram/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:evogram/presentation/bloc/fetch_followings_bloc/fetch_followings_bloc.dart';
import 'package:evogram/presentation/bloc/login_user_bloc/login_user_bloc.dart';
import 'package:evogram/presentation/screens/followers_screen/followers_screen.dart';
import 'package:evogram/presentation/screens/following_screen/following_screen.dart';
import 'package:evogram/presentation/screens/userprofile/edit_profile/edit_profile.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/my_post/specific_uploadedpost.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/my_post/widgets/gridshimmer.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/profile_styles.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:evogram/presentation/screens/widgets/custom_profile_button.dart';
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
        decoration: const BoxDecoration(
          color: blueaccent,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(child: gridshimmer(context)),
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: state.users.backGroundImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
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
                            : darkgreymain),
                    borderRadius: BorderRadius.circular(100)),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => ImageDialouge(
                              image: state.users.profilePic,
                            ));
                  },
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: state.users.profilePic,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return circleshimmer(context);
                      },
                    ),
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
          state.users.name != null
              ? state.users.name.toString()
              : 'GuestUser102934',
          style: profilestyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Text(
          state.users.bio != null ? state.users.bio.toString() : '',
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
                  onTap: state.userposts.length != 0
                      ? () {
                          navigatePushAnimaterbottomtotop(
                              context,
                              UserPosts(
                                userId: state.userposts[0].userId.id,
                                initialindex: 0,
                              ));
                        }
                      : () {},
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
                    onTap: state.followers.totalCount != 0
                        ? () {
                            navigatePushAnimaterbottomtotop(
                                context,
                                FollowersScreen(
                                  followers: state.followers.followers,
                                ));
                          }
                        : () {},
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
                  onTap: followingsModel.totalCount != 0
                      ? () {
                          navigatePushAnimaterbottomtotop(
                              context,
                              FollowingPersonScreen(
                                model: followingsModel,
                                following: state.followingsModel.following,
                              ));
                        }
                      : () {},
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
              child: CustomProfileButton(
                size: size,
                text: 'Edit Profile',
                width: .5,
              )),
        ],
      ),
      h20,
    ]),
  );
}

class ImageDialouge extends StatelessWidget {
  final String image;
  const ImageDialouge({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      surfaceTintColor: black,
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipOval(
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return circleshimmer(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
