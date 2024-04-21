// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:chihebapp2/Services/feedbackProvider.dart';
import 'package:chihebapp2/models/feedbackModel.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/acceptOrDeclineWidget.dart';
import 'package:chihebapp2/widgets/appbar.dart';
import 'package:chihebapp2/widgets/drawerWidget.dart';
import 'package:chihebapp2/widgets/errorMessage.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:chihebapp2/widgets/loadingWidget.dart';
import 'package:chihebapp2/widgets/pendingPostWidget.dart';
import 'package:chihebapp2/widgets/searchWidget.dart';
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
  TextEditingController search = TextEditingController();
  bool isLoading = false;
  List<FeedbackModel> filteredFeedbacks = [];
  List<FeedbackModel> feedbacks = [];
  @override
  void initState() {
    super.initState();
    fetchFeedbacks();
  }

  Future<void> fetchFeedbacks() async {
    try {
      setState(() {
        isLoading = true;
      });
      filteredFeedbacks =
          await context.read<FeedbackProvider>().getNonApprovedFeedbacks();
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
      appBar: appBar(context, 'Posts en attente'),
      drawer: DrawerWidget(),
      body: Column(
        children: [
          SearchWidget(search, (value) {
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
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredFeedbacks.length,
                            itemBuilder: (context, index) {
                              FeedbackModel feedback = filteredFeedbacks[index];
                              return PendingPostWidget(
                                  feedback.user.image,
                                  feedback.user.displayName,
                                  formatDate(feedback.createdAt),
                                  () {approvePost(feedback.id);},
                                  () {refusePost(feedback.id);},
                                  feedback.name,
                                  feedback.message,
                                  feedback.link,
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
                "Êtes vous sûr?", "Voulez-vous vraiment refuser ce post?",
                () async {
              setState(() {
                isLoading = true;
              });
              try {
                await context
                    .read<FeedbackProvider>()
                    .deleteFeedback(id)
                    .then((value) {
                  Navigator.of(context).pop();
                  fetchFeedbacks().then((value) => setState(() {
                        isLoading = false;
                      }));
                });
              } catch (err) {
                showDialog(
                  context: context,
                  builder: (context) =>
                      ErrorPopUp('Alert', err.toString(), redColor),
                );
              }
            }));
  }

  approvePost(String id) {
    showDialog(
        context: context,
        builder: (context) => AcceptOrDecline(
                "Êtes vous sûr?", "Voulez-vous vraiment approuver ce post?",
                () async {
              setState(() {
                isLoading = true;
              });
              try {
                await context
                    .read<FeedbackProvider>()
                    .approveFeedback(id)
                    .then((value) {
                  Navigator.of(context).pop();
                  fetchFeedbacks().then((value) => setState(() {
                        isLoading = false;
                      }));
                });
              } catch (err) {
                showDialog(
                  context: context,
                  builder: (context) =>
                      ErrorPopUp('Alert', err.toString(), redColor),
                );
              }
            }));
  }
}
