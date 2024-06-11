// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/core/constants.dart';
import 'package:evogram/infrastructure/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:evogram/presentation/userprofile/profile_screen/widgets/specific_uploadedpost.dart';
import 'package:evogram/presentation/widgets/custom_navigators.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GridviewProfile extends StatelessWidget {
  const GridviewProfile({super.key, required this.state});
  final FetchUserPostSuccessState state;

  @override
  Widget build(context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.grey[300]
            : darkgreymain,
        body: state.userposts.isEmpty
            ? Center(
                child: Image.asset(
                  nopostblack,
                  color: grey,
                  width: size.width * .5,
                ),
              )
            : GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: .1,
                crossAxisSpacing: .03,
                childAspectRatio: 1 / 1,
                children: List.generate(state.userposts.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      navigatePushAnimaterbottomtotop(
                          context,
                          UserPosts(
                            userId: state.userposts[index].userId.id,
                            initialindex: index,
                          ));
                    },
                    child: Card(
                      child: GridTile(
                          child: CachedNetworkImage(
                              imageUrl: state.userposts[index].image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) {
                                return LoadingAnimationWidget.hexagonDots(
                                    color: blueaccent, size: 30);
                              })),
                    ),
                  );
                }),
              ));
  }
}
