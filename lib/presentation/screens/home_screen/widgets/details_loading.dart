import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer detailsShimmerLoading(BuildContext context) {
  return Shimmer.fromColors(
      highlightColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade100
          : darkgrey,
      baseColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade300
          : darkbg,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          margin: const EdgeInsets.only(bottom: 110),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 220,
              ),
              Positioned(
                left: 20,
                top: 130,
                width: MediaQuery.of(context).size.width - 40,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: white),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                ),
              ),
              const Positioned(
                left: 40,
                top: 60,
                child: CircleAvatar(
                  radius: 68,
                  backgroundColor: white,
                  child: CircleAvatar(
                    radius: 65,
                    backgroundColor: white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
}
