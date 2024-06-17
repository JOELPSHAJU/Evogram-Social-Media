import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer commentsShimmerLoading(context) {
  return Shimmer.fromColors(
      direction: ShimmerDirection.ttb,
      highlightColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade100
          : darkgrey,
      baseColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade300
          : darkbg,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: black,
                  ),
                  w10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: white,
                          ),
                          height: 20,
                          width: MediaQuery.of(context).size.width,
                        ),
                        h10,
                        Container(
                          height: 10,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }));
}
