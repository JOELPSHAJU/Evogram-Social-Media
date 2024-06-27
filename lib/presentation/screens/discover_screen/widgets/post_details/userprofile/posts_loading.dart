import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer postsShimmerLoading() {
  return Shimmer.fromColors(
    highlightColor: Colors.grey.shade100,
    baseColor: Colors.grey.shade300,
    child: GridView.builder(
      padding: const EdgeInsets.all(5),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: white,
          ),
          margin: const EdgeInsets.all(5),
        );
      },
    ),
  );
}
