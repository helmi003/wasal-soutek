// ignore_for_file: prefer_const_constructors

import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/feedbackImages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FullScreenImage extends StatefulWidget {
  final List images;
  FullScreenImage(this.images);

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            FeedbackImages(500,widget.images),
            Positioned(
                top: 0,
                left: 20,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      FontAwesomeIcons.arrowLeft,
                      size: 25,
                      color: lightColor,
                    )))
          ],
        ),
      ),
    );
  }
}
