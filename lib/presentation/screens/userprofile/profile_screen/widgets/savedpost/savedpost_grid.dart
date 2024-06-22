// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/saved_post_model.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/my_post/widgets/gridshimmer.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/savedpost/saved_posts_details.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:flutter/material.dart';

class SavedPostGrid extends StatelessWidget {
  final List<SavedPostModel> saveddata;
  const SavedPostGrid({super.key, required this.saveddata});

  @override
  Widget build(context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.grey[300]
            : darkgreymain,
        body: saveddata.isEmpty
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
                crossAxisSpacing: .1,
                childAspectRatio: 1 / 1,
                children: List.generate(saveddata.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      navigatePushAnimaterbottomtotop(
                          context,
                          SavedPostsDetailsScreen(
                            initialindex: index,
                          ));
                    },
                    child: Card(
                      child: GridTile(
                          child: CachedNetworkImage(
                        imageUrl: saveddata[index].postId.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return gridshimmer(context);
                        },
                      )),
                    ),
                  );
                }),
              ));
  }
}
