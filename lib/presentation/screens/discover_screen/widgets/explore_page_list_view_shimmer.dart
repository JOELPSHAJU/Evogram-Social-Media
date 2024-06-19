import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer explorePageLoading() {
  return Shimmer.fromColors(
    highlightColor: Colors.grey.shade100,
    baseColor: Colors.grey.shade300,
    child: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: lightgreyauth,
                radius: 28,
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: white,
                ),
              ),
              w10,
              Container(
                height: 20,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: lightgreyauth),
              ),
              const Spacer(),
              Container(
                height: 28,
                width: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: lightgreyauth),
              )
            ],
          ),
        );
      },
    ),
  );
}
