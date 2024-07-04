// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:chihebapp2/Services/feedbackProvider.dart';
import 'package:chihebapp2/Services/userProvider.dart';
import 'package:chihebapp2/models/feedbackModel.dart';
import 'package:chihebapp2/screens/search_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/acceptOrDeclineWidget.dart';
import 'package:chihebapp2/widgets/appbar.dart';
import 'package:chihebapp2/widgets/circularLoadingWidget.dart';
import 'package:chihebapp2/widgets/drawerWidget.dart';
import 'package:chihebapp2/widgets/errorMessage.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:chihebapp2/widgets/loadingWidget.dart';
import 'package:chihebapp2/widgets/postWidgte.dart';
import 'package:chihebapp2/widgets/searchButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BadFeedbacksScreen extends StatefulWidget {
  const BadFeedbacksScreen({super.key});

  @override
  State<BadFeedbacksScreen> createState() => _BadFeedbacksScreenState();
}

class _BadFeedbacksScreenState extends State<BadFeedbacksScreen> {
  bool isLoading = false;
  bool isLoadingMore = false;
  List<FeedbackModel> filteredFeedbacks = [];
  List<FeedbackModel> feedbacks = [];
  int currentPage = 1;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    fetchFeedbacks();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoadingMore) {
        loadMoreFeedbacks();
      }
    });
  }

  Future<void> fetchFeedbacks() async {
    try {
      setState(() {
        isLoading = true;
      });
      filteredFeedbacks =
          await context.read<FeedbackProvider>().getBadFeedbacks(currentPage);
      feedbacks = filteredFeedbacks;
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> loadMoreFeedbacks() async {
    try {
      setState(() {
        isLoadingMore = true;
        currentPage++;
      });
      List<FeedbackModel> fetchedFeedbacks =
          await context.read<FeedbackProvider>().getBadFeedbacks(currentPage);
      setState(() {
        feedbacks.addAll(fetchedFeedbacks);
        filteredFeedbacks = feedbacks;
        isLoadingMore = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user =
        Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context, 'Avis négatifs'),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          SearchButton(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchFeedbacksScreen("negative")));
          }),
          SizedBox(height: 10.h),
          isLoading
              ? Center(child: LoadingWidget())
              : filteredFeedbacks.isEmpty
                      ? Center(child: ErrorMesssage('Aucun post disponible.'))
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: filteredFeedbacks.length +
                                (isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == filteredFeedbacks.length) {
                                return CircularLoadingWidget();
                              }
                              FeedbackModel feedback = filteredFeedbacks[index];
                              return PostWidget(
                                  feedback.id,
                                  feedback.review,
                                  feedback.user.image,
                                  feedback.user.displayName,
                                  formatDate(feedback.createdAt),
                                  feedback.user.id == user['user']['_id'] ||
                                      user['user']['role'] == 'admin', () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AcceptOrDecline(
                                            "Êtes vous sûr?",
                                            "Voulez-vous vraiment supprimer ce post?",
                                            () {
                                          deletePost(feedback.id);
                                        }));
                              }, feedback.name, feedback.message, feedback.link,
                                  feedback.images);
                            },
                          ),
                        ),
        ],
      ),
    );
  }

  String formatDate(String date) {
    return DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.parse(date));
  }

  deletePost(String id) async {
    try {
      setState(() {
        isLoading = true;
      });
      await context.read<FeedbackProvider>().deleteFeedback(id);
      Navigator.of(context).pop();
      fetchFeedbacks();
      setState(() {
        currentPage = 1;
      });
    } catch (err) {
      showDialog(
        context: context,
        builder: (context) => ErrorPopUp('Alert', err.toString(), redColor),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
