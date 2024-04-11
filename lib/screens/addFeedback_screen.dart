// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/appbar.dart';
import 'package:chihebapp2/widgets/buttonWidget.dart';
import 'package:chihebapp2/widgets/choosePictureType.dart';
import 'package:chihebapp2/widgets/drawerWidget.dart';
import 'package:chihebapp2/widgets/dropDownWidget.dart';
import 'package:chihebapp2/widgets/textArea.dart';
import 'package:chihebapp2/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _photo;
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
            TextFieldWidget(companyName, "Nom d'association *", companyNameError),
            TextFieldWidget(link, "Lien d'association", ""),
            DropDownWidget(items, (value) {
              setState(() {
                selectedItem = value;
              });
            }, 'Choisissez une option *', null, selectedItemError,selectedItem),
            CustomTextArea(message, 'Message...', messageError),
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
            ButtonWidget(() {}, "Ajouter", isLoading),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  takephoto(ImageSource source) async {
    final pick = await imagePicker.pickImage(source: source);
    if (pick != null) {
      setState(() {
        _photo = File(pick.path);
      });
    }
  }
}
