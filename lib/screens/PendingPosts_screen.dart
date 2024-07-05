// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:chihebapp2/Services/feedbackProvider.dart';
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
import 'package:chihebapp2/widgets/pendingPostWidget.dart';
import 'package:chihebapp2/widgets/searchButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PendingFeedbacksScreen extends StatefulWidget {
  const PendingFeedbacksScreen({super.key});

  @override
  State<PendingFeedbacksScreen> createState() => _PendingFeedbacksScreenState();
}

class _PendingFeedbacksScreenState extends State<PendingFeedbacksScreen> {
  bool isLoading = false;
  bool isLoadingMore = false;
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
        currentPage = 1;
      });
      feedbacks = await context
          .read<FeedbackProvider>()
          .getNonApprovedFeedbacks(currentPage);
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
      List<FeedbackModel> fetchedFeedbacks = await context
          .read<FeedbackProvider>()
          .getNonApprovedFeedbacks(currentPage);
      setState(() {
        feedbacks.addAll(fetchedFeedbacks);
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
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context, 'Posts en attente'),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          SearchButton(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchFeedbacksScreen("pending")));
          }),
          SizedBox(height: 10.h),
          isLoading
              ? Center(child: LoadingWidget())
              : feedbacks.isEmpty
                  ? Center(child: ErrorMesssage('Aucun post disponible.'))
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: feedbacks.length + (isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == feedbacks.length) {
                            return CircularLoadingWidget();
                          }
                          FeedbackModel feedback = feedbacks[index];
                          return PendingPostWidget(
                              feedback.user.image,
                              feedback.user.displayName,
                              formatDate(feedback.createdAt),
                              feedback.review, () {
                            approvePost(feedback.id);
                          }, () {
                            refusePost(feedback.id);
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

  refusePost(String id) {
    showDialog(
        context: context,
        builder: (context) => AcceptOrDecline(
                "Êtes vous sûr?", "Etes-vous sûr de refuser ce post?",
                () async {
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
                  builder: (context) =>
                      ErrorPopUp('Alert', err.toString(), redColor),
                );
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            }));
  }

  approvePost(String id) {
    showDialog(
        context: context,
        builder: (context) => AcceptOrDecline(
                "Êtes vous sûr?", "Etes-vous sûr d'approuver ce post?",
                () async {
              try {
                setState(() {
                  isLoading = true;
                });
                await context.read<FeedbackProvider>().approveFeedback(id);
                Navigator.of(context).pop();
                fetchFeedbacks();
                setState(() {
                  currentPage = 1;
                });
              } catch (err) {
                showDialog(
                  context: context,
                  builder: (context) =>
                      ErrorPopUp('Alert', err.toString(), redColor),
                );
              } finally {
                setState(() {
                  isLoading = false;
                });
              }
            }));
  }
}
