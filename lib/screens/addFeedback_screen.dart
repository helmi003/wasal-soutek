// ignore_for_file: prefer_const_constructors, prefer_final_fields, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';

import 'package:chihebapp2/Services/feedbackProvider.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/appbar.dart';
import 'package:chihebapp2/widgets/buttonWidget.dart';
import 'package:chihebapp2/widgets/choosePictureType.dart';
import 'package:chihebapp2/widgets/drawerWidget.dart';
import 'package:chihebapp2/widgets/dropDownWidget.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:chihebapp2/widgets/textArea.dart';
import 'package:chihebapp2/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddFeedbackScreen extends StatefulWidget {
  const AddFeedbackScreen({super.key});

  @override
  State<AddFeedbackScreen> createState() => _AddFeedbackScreenState();
}

class _AddFeedbackScreenState extends State<AddFeedbackScreen> {
  TextEditingController companyName = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController message = TextEditingController();
  String companyNameError = "";
  String messageError = "";
  bool isLoading = false;
  List items = ["Je recommande", "Je ne recommande pas"];
  String selectedItem = "";
  String selectedItemError = "";
  List<XFile> photos = [];
  String photo = "";
  ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBar(context, 'Ajouter avis'),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                "Ici, vous pouvez ajouter votre avis que ce soit pour ou contre un service, fourniseur, entreprise...etc avec les memebres de cette application.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: darkColor),
              ),
            ),
            SizedBox(height: 20.h),
            TextFieldWidget(
                companyName, "Nom d'association *", companyNameError),
            TextFieldWidget(link, "Lien d'association", ""),
            DropDownWidget(items, (value) {
              setState(() {
                selectedItem = value;
              });
            }, 'Choisissez une option *', null, selectedItemError,
                selectedItem),
            CustomTextArea(message, 'Message...', messageError),
            photos.isEmpty
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          clearAll();
                        },
                        child: Text(
                          'Clear all',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                              color: primaryColor),
                        ),
                      ),
                    ),
                  ),
            photos.isEmpty
                ? SizedBox()
                : Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(width: 2, color: darkColor),
                      ),
                    ),
                    height: 110.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: photos.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: GestureDetector(
                          onTap: () {
                            removePhoto(index);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.file(
                                File(photos[index].path),
                                width: 100.w,
                                height: 100.h,
                              ),
                              Icon(
                                FontAwesomeIcons.xmark,
                                color: redColor,
                                size: 25.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/picture.png',
                    width: 200.w,
                  ),
                  Icon(
                    FontAwesomeIcons.plus,
                    color: lightColor,
                    size: 40.h,
                  ),
                ],
              ),
              onTap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.r),
                      topLeft: Radius.circular(16.r),
                    ),
                  ),
                  backgroundColor: primaryColor,
                  context: context,
                  builder: ((builder) => BottomSheetCamera(
                        () {
                          takephoto(
                            ImageSource.camera,
                          );
                        },
                        () {
                          takephoto(
                            ImageSource.gallery,
                          );
                        },
                      )),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "cliquez sur l'image ci-dessus pour ajouter quelques photos",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: darkColor),
              ),
            ),
            SizedBox(height: 10.h),
            ButtonWidget(addFeedback, "Ajouter", isLoading),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  takephoto(ImageSource source) async {
    if (source == ImageSource.camera) {
      final pick = await imagePicker.pickImage(source: source);
      if (pick != null) {
        setState(() {
          photos.add(pick);
        });
      }
    } else {
      final pick = await imagePicker.pickMultiImage();
      if (pick != null) {
        setState(() {
          photos.addAll(pick);
        });
      }
    }
  }

  void removePhoto(int index) {
    setState(() {
      photos.removeAt(index);
    });
  }

  void clearAll() {
    setState(() {
      photos = [];
    });
  }

  addFeedback() async {
    if (companyName.text.isEmpty) {
      setState(() {
        companyNameError = "Ce champ est obligatoire";
        selectedItemError = "";
        messageError = "";
      });
    } else if (selectedItem == "") {
      setState(() {
        companyNameError = "";
        selectedItemError = "Vous devez choisir une option";
        messageError = "";
      });
    } else if (message.text.isEmpty) {
      setState(() {
        companyNameError = "";
        selectedItemError = "";
        messageError = "Ce champ est obligatoire";
      });
    } else if (photos.isEmpty) {
      showDialog(
        context: context,
        builder: (context) =>
            ErrorPopUp('Alert', 'Il faut choisir au moins une photo', redColor),
      );
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        bool review = false;
        if (selectedItem == "Je recommande") {
          review = true;
        }
        await context
            .read<FeedbackProvider>()
            .addFeedback(
                companyName.text, link.text, message.text, photos, review)
            .then((value) {
          setState(() {
            companyName.clear();
            link.clear();
            message.clear();
          });
          showDialog(
            context: context,
            builder: ((context) => ErrorPopUp(
                "Succés", "Votre post est publié avec succès", greenColor)),
          );
        });
      } catch (onError) {
        showDialog(
          context: context,
          builder: ((context) =>
              ErrorPopUp("Alert", onError.toString(), redColor)),
        );
        print(onError.toString());
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
