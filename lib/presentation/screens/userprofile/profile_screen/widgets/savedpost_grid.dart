// ignore_for_file: must_be_immutable

import 'package:evogram/application/core/constants.dart';
import 'package:evogram/domain/models/saved_post_model.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/saved_posts_details.dart';
import 'package:evogram/presentation/screens/widgets/custom_navigators.dart';
import 'package:flutter/material.dart';

class SavedPostGrid extends StatelessWidget {
  final List<SavedPostModel> saveddata;
  SavedPostGrid({super.key, required this.saveddata});

  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.grey[300]
            : darkgreymain,
        body: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: .1,
          crossAxisSpacing: .1,
          childAspectRatio: 1 / 1,
          children: List.generate(saveddata.length, (index) {
            return GestureDetector(
              onTap: () {
                navigatePush(
                    context,
                    SavedPostsDetailsScreen(
                      initialindex: index,
                    ));
              },
              child: Card(
                child: GridTile(
                  child: Image.network(
                    saveddata[index].postId.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
