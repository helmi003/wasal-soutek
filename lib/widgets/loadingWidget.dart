// ignore_for_file: prefer_const_constructors

import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.flickr(
        leftDotColor: primaryColor,
        rightDotColor: secondaryColor,
        size: 50,
      ),
    );
  }
}
