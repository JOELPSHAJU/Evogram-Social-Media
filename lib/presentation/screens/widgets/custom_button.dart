import 'package:evogram/application/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

MaterialButton loadingButton(
    {required Size media,
    required VoidCallback onPressed,
    required Color color}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    minWidth: media.width,
    height: media.height * 0.06,
    color: color,
    child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
      color: white,
      size: 40,
    )),
  );
}
