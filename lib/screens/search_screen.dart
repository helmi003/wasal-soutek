// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:chihebapp2/Services/feedbackProvider.dart';
import 'package:chihebapp2/Services/userProvider.dart';
import 'package:chihebapp2/models/feedbackModel.dart';
import 'package:chihebapp2/screens/PendingPosts_screen.dart';
import 'package:chihebapp2/screens/tab_screen.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/acceptOrDeclineWidget.dart';
import 'package:chihebapp2/widgets/circularLoadingWidget.dart';
import 'package:chihebapp2/widgets/errorMessage.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:chihebapp2/widgets/loadingWidget.dart';
import 'package:chihebapp2/widgets/pendingPostWidget.dart';
import 'package:chihebapp2/widgets/postWidgte.dart';
import 'package:chihebapp2/widgets/searchWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SearchFeedbacksScreen extends StatefulWidget {
  final String type;
  SearchFeedbacksScreen(this.type);

  @override
  State<SearchFeedbacksScreen> createState() => _SearchFeedbacksScreenState();
}

class _SearchFeedbacksScreenState extends State<SearchFeedbacksScreen> {
  TextEditingController search = TextEditingController(text: "");
  bool isLoading = false;
  bool isLoadingMore = false;
  List<FeedbackModel> searchFeedbacks = [];
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
      searchFeedbacks = await context
          .read<FeedbackProvider>()
          .filterFeedbacks(widget.type, search.text, currentPage);
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
          .filterFeedbacks(widget.type, search.text, currentPage);
      setState(() {
        searchFeedbacks.addAll(fetchedFeedbacks);
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
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: lightColor),
        title: Text(
          "Recherche",
          style: TextStyle(
              fontSize: 25.sp, fontWeight: FontWeight.w500, color: lightColor),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 28.h,
            color: lightColor,
          ),
          onPressed: () {
            if (widget.type == "pending") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PendingFeedbacksScreen()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabScreen(
                            page: 0,
                          )));
            }
          },
        ),
      ),
      body: Column(
        children: [
          SearchWidget(search, () {
            fetchFeedbacks();
          }),
          SizedBox(height: 10.h),
          isLoading
              ? Center(child: LoadingWidget())
              : searchFeedbacks.isEmpty && search.text != ""
                  ? Center(
                      child: ErrorMesssage("Il n'y a pas de correspondance"))
                  : searchFeedbacks.isEmpty
                      ? Center(child: ErrorMesssage('Aucun post disponible.'))
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: searchFeedbacks.length +
                                (isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == searchFeedbacks.length) {
                                return CircularLoadingWidget();
                              }
                              FeedbackModel feedback = searchFeedbacks[index];
                              return widget.type != "pending"
                                  ? PostWidget(
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
                                                deletePost(feedback.id,
                                                    feedback.review);
                                              }));
                                    }, feedback.name, feedback.message,
                                      feedback.link, feedback.images)
                                  : PendingPostWidget(
                                      feedback.user.image,
                                      feedback.user.displayName,
                                      formatDate(feedback.createdAt),
                                      feedback.review, () {
                                      approvePost(feedback.id);
                                    }, () {
                                      refusePost(feedback.id);
                                    }, feedback.name, feedback.message,
                                      feedback.link, feedback.images);
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

  deletePost(String id, bool review) async {
    try {
      setState(() {
        isLoading = true;
      });
      await context.read<FeedbackProvider>().deleteFeedback(id);
      fetchFeedbacks();
      Navigator.of(context).pop(true);
      setState(() {
        if (review) {
          Provider.of<FeedbackProvider>(context, listen: false)
              .removeGoodFeedback(id);
        } else {
          Provider.of<FeedbackProvider>(context, listen: false)
              .removeBadFeedback(id);
        }
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
                  Provider.of<FeedbackProvider>(context, listen: false)
                      .removePendingFeedback(id);
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
                  Provider.of<FeedbackProvider>(context, listen: false)
                      .removePendingFeedback(id);
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
