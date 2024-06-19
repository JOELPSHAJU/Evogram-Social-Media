import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer gridshimmer(BuildContext context) {
  return Shimmer.fromColors(
      highlightColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade200
          : darkgrey,
      baseColor: Theme.of(context).brightness == Brightness.light
          ? Colors.grey.shade400
          : darkbg,
      child: Container(
        decoration:
            BoxDecoration(color: white, borderRadius: BorderRadius.circular(8)),
      ));
}
