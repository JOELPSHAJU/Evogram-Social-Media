import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer followersLoading(context) {
  return Shimmer.fromColors(
    highlightColor: Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade100
        : darkbg,
    baseColor: Theme.of(context).brightness == Brightness.light
        ? Colors.grey.shade300
        : darkgrey,
    child: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: white,
                    radius: 28,
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: lightgreyauth,
                    ),
                  ),
                  w10,
                  Container(
                    height: 20,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), color: white),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), color: white),
                    height: 28,
                    width: 70,
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
