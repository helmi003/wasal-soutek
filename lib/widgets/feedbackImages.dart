// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeedbackImages extends StatefulWidget {
  final List images;
  FeedbackImages(this.images);

  @override
  State<FeedbackImages> createState() => _FeedbackImagesState();
}

class _FeedbackImagesState extends State<FeedbackImages> {
  int activeIndex = 0;
  final controller = CarouselController();
  final url = dotenv.env['API_URL'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
            carouselController: controller,
            itemCount: widget.images.length,
            itemBuilder: (context, index, realIndex) {
              return buildImage("$url/uploads/${widget.images[index]}", index);
            },
            options: CarouselOptions(
                height: 300.h,
                autoPlay: true,
                enableInfiniteScroll: false,
                autoPlayAnimationDuration: Duration(seconds: 2),
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index))),
        SizedBox(height: 12),
        if (widget.images.length > 1) buildIndicator()
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(dotWidth: 15, activeDotColor: primaryColor),
        activeIndex: activeIndex,
        count: widget.images.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) => Container(
    constraints: BoxConstraints(maxHeight: 400.h),
    child: Image.network(urlImage, fit: BoxFit.cover));
