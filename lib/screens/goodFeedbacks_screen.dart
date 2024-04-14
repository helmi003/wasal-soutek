// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:chihebapp2/Services/feedbackProvider.dart';
import 'package:chihebapp2/models/feedbackModel.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/acceptOrDeclineWidget.dart';
import 'package:chihebapp2/widgets/appbar.dart';
import 'package:chihebapp2/widgets/drawerWidget.dart';
import 'package:chihebapp2/widgets/errorMessage.dart';
import 'package:chihebapp2/widgets/loadingWidget.dart';
import 'package:chihebapp2/widgets/postWidgte.dart';
import 'package:chihebapp2/widgets/searchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GoodFeedbacksScreen extends StatefulWidget {
  const GoodFeedbacksScreen({super.key});

  @override
  State<GoodFeedbacksScreen> createState() => _GoodFeedbacksScreenState();
}

class _GoodFeedbacksScreenState extends State<GoodFeedbacksScreen> {
  TextEditingController search = TextEditingController();
  bool isLoading = false;
  List<FeedbackModel> filteredFeedbacks = [];
  List<FeedbackModel> feedbacks = [];
  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    try {
      setState(() {
        isLoading = true;
      });
      filteredFeedbacks =
          await context.read<FeedbackProvider>().getGoodFeedbacks();
      feedbacks = filteredFeedbacks;
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context, 'Avis positifs'),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SearchWidget(search, "Rechercher un post", (value) {
              setState(() {
                if (value.isEmpty) {
                  filteredFeedbacks = feedbacks;
                } else {
                  filteredFeedbacks = feedbacks
                      .where((feedback) =>
                          search.text.isEmpty ||
                          feedback.name
                              .toLowerCase()
                              .contains(search.text.toLowerCase()))
                      .toList();
                }
              });
            }),
            SizedBox(height: 10.h),
            isLoading
                ? Center(child: LoadingWidget())
                : filteredFeedbacks.isEmpty && search.text != ""
                    ? Center(
                        child: ErrorMesssage("Il n'y a pas de correspondance"))
                    : filteredFeedbacks.isEmpty
                        ? Center(child: ErrorMesssage('Aucun post disponible.'))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredFeedbacks.length,
                            itemBuilder: (context, index) {
                              FeedbackModel feedback = filteredFeedbacks[index];
                              return PostWidget(
                                  'assets/images/user.png',
                                  'Helmi Ben Romdhane',
                                  formatDate(feedback.createdAt), () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AcceptOrDecline(
                                        "Êtes vous sûr?",
                                        "Voulez-vous vraiment supprimer ce post?",
                                        () {}));
                              }, feedback.name, feedback.message, feedback.link,
                                  feedback.images);
                            },
                          ),
          ],
        ),
      ),
    );
  }

  String formatDate(String date) {
    return DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.parse(date));
  }
}
