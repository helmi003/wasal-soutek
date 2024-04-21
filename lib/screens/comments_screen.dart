// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:chihebapp2/Services/commentsProvider.dart';
import 'package:chihebapp2/Services/feedbackProvider.dart';
import 'package:chihebapp2/Services/userProvider.dart';
import 'package:chihebapp2/models/comment.dart';
import 'package:chihebapp2/screens/tab_screen.dart';
import 'package:chihebapp2/widgets/acceptOrDeclineWidget.dart';
import 'package:chihebapp2/widgets/addComment.dart';
import 'package:chihebapp2/widgets/errorMessage.dart';
import 'package:chihebapp2/widgets/feedbackImages.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/backAppbar.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:chihebapp2/widgets/loadingWidget.dart';
import 'package:chihebapp2/widgets/peopleCommentWidget.dart';
import 'package:chihebapp2/widgets/yourMessageWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentsScreen extends StatefulWidget {
  final String id;
  final bool review;
  final String userImage;
  final String name;
  final String time;
  final bool allowedToDelete;
  final String entreprise;
  final String message;
  final String lien;
  final List images;
  CommentsScreen(
      this.id,
      this.review,
      this.userImage,
      this.name,
      this.time,
      this.allowedToDelete,
      this.entreprise,
      this.message,
      this.lien,
      this.images);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController messageController = TextEditingController();
  final url = dotenv.env['API_URL'];
  bool isLoading = false;
  String photo = "";
  List<CommentModel> comments = [];
  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      setState(() {
        isLoading = true;
      });
      comments = await context.read<CommentProvider>().getComments(widget.id);
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user =
        Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: backAppBar(context, widget.entreprise),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: InstaImageViewer(
                    child: CircleAvatar(
                        radius: 20.r,
                        backgroundImage: NetworkImage(
                            "$url/${widget.userImage.replaceAll('\'', '/')}")),
                  ),
                  title: Text(
                    widget.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        color: darkColor),
                  ),
                  subtitle: Text(
                    widget.time,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: darkColor),
                  ),
                  trailing: widget.allowedToDelete
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            color: darkColor,
                            size: 25.h,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AcceptOrDecline(
                                        "Êtes vous sûr?",
                                        "Voulez-vous vraiment supprimer ce post?",
                                        () {
                                      deletePost(widget.id);
                                    }));
                          },
                        )
                      : null,
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Text(
                      widget.message,
                      style: TextStyle(color: darkColor),
                    )),
                if (widget.lien != "")
                  Padding(
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 10.h),
                      child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: "Lien d'entreprise: ",
                              style: TextStyle(
                                color: darkColor,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: primaryColor,
                                      decoration: TextDecoration.underline),
                                  text: widget.lien,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      try {
                                        await launchUrl(Uri.parse(widget.lien));
                                      } catch (e) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => ErrorPopUp(
                                            'Alert',
                                            'Ce lien est inaccessible pour le moment',
                                            redColor,
                                          ),
                                        );
                                      }
                                    },
                                )
                              ]))),
                FeedbackImages(300, widget.images),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      'Comentaires:',
                      style: TextStyle(
                          fontSize: 25.sp,
                          color: primaryColor,
                          fontWeight: FontWeight.w700),
                    )),
                comments.isEmpty
                    ? Center(
                        child:
                            ErrorMesssage('Aucun commentaire pour le moment.'))
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: comments.length,
                        itemBuilder: (context, index) => user['user']['_id'] ==
                                comments[index].user.id
                            ? YourMessageWidget(
                                comments[index].message,
                                formatDate(comments[index].createdAt),
                                comments[index].show, () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AcceptOrDecline(
                                            "Êtes vous sûr?",
                                            "Voulez-vous vraiment supprimer ce commentaire?",
                                            () {
                                          deleteComment(comments[index].id);
                                        }));
                              }, () {
                                setState(() {
                                  Provider.of<CommentProvider>(context,
                                          listen: false)
                                      .toggleShow(comments[index]);
                                });
                              })
                            : PeopleCommnetWidget(
                                comments[index].user.displayName,
                                comments[index].user.image,
                                comments[index].message,
                                formatDate(comments[index].createdAt),
                                comments[index].show, () {
                                if (user['user']['role'] == "admin") {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AcceptOrDecline(
                                              "Êtes vous sûr?",
                                              "Voulez-vous vraiment supprimer ce commentaire?",
                                              () {
                                            deleteComment(comments[index].id);
                                          }));
                                }
                              }, () {
                                setState(() {
                                  Provider.of<CommentProvider>(context,
                                          listen: false)
                                      .toggleShow(comments[index]);
                                });
                              }),
                      ),
                SizedBox(
                  height: 70.h,
                )
              ],
            ),
          ),
          if (isLoading)
            Container(
              height: MediaQuery.of(context).size.height,
              color: darkColor.withOpacity(0.5),
              child: LoadingWidget(),
            ),
        ],
      ),
      bottomSheet: AddComment(messageController, addCommentaire),
    );
  }

  addCommentaire() async {
    if (messageController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => ErrorPopUp(
              'Alert', "Vous devez d'abord ajouter un message", redColor));
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        await context
            .read<CommentProvider>()
            .addComment(widget.id, messageController.text)
            .then((value) {
          setState(() {
            messageController.clear();
          });
        });
        fetchComments();
      } catch (onError) {
        showDialog(
          context: context,
          builder: ((context) =>
              ErrorPopUp("Alert", onError.toString(), redColor)),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String formatDate(String date) {
    return DateFormat('HH:mm - dd/MM/yyyy').format(DateTime.parse(date));
  }

  deleteComment(String id) async {
    setState(() {
      isLoading = true;
    });
    try {
      await context.read<CommentProvider>().deleteComment(id).then((value) {
        Navigator.of(context).pop();
        fetchComments().then((value) => setState(() {
              isLoading = false;
            }));
      });
    } catch (err) {
      showDialog(
        context: context,
        builder: (context) => ErrorPopUp('Alert', err.toString(), redColor),
      );
    }
  }

  deletePost(String id) async {
    setState(() {
      isLoading = true;
    });
    try {
      await context
          .read<FeedbackProvider>()
          .deleteFeedback(id)
          .then((value) async {
        if (widget.review) {
          await context
              .read<FeedbackProvider>()
              .getGoodFeedbacks()
              .then((value) {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, TabScreen.routeName);
            showDialog(
                context: context,
                builder: (context) => ErrorPopUp('Succés',
                    "Votre post a été supprimé avec succès", greenColor));
          });
        } else {
          await context
              .read<FeedbackProvider>()
              .getBadFeedbacks()
              .then((value) {
            Navigator.of(context).pop();
            Navigator.pushReplacementNamed(context, TabScreen.routeName);
            showDialog(
                context: context,
                builder: (context) => ErrorPopUp('Succés',
                    "Votre post a été supprimé avec succès", greenColor));
          });
        }
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
