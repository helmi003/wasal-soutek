// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:chihebapp2/Services/userProvider.dart';
import 'package:chihebapp2/utils/colors.dart';
import 'package:chihebapp2/widgets/appbar.dart';
import 'package:chihebapp2/widgets/buttonWidget.dart';
import 'package:chihebapp2/widgets/choosePictureType.dart';
import 'package:chihebapp2/widgets/drawerWidget.dart';
import 'package:chihebapp2/widgets/errorPopUp.dart';
import 'package:chihebapp2/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController displayNameController = TextEditingController();
  String displayNameError = "";
  bool isLoading = false;
  Map<String, dynamic> user = {};
  File? photo;
  ImagePicker imagePicker = ImagePicker();
  @override
  void initState() {
    super.initState();
    user = Provider.of<UserProvider>(context, listen: false).user;
    displayNameController.text = user['user']['displayName'];
  }

  @override
  Widget build(BuildContext context) {
    final url = dotenv.env['API_URL'];
    user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: appBar(context, 'Modifier votre profil'),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Stack(
              children: [
                photo == null
                    ? CircleAvatar(
                        radius: 90.r,
                        backgroundImage: NetworkImage(
                            "$url/${user['user']['image'].replaceAll('\'', '/')}"))
                    : CircleAvatar(
                        radius: 90.r, backgroundImage: FileImage(photo!)),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(50.r)),
                      child: IconButton(
                          onPressed: () {
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
                                      takephoto(ImageSource.camera);
                                    },
                                    () {
                                      takephoto(ImageSource.gallery);
                                    },
                                  )),
                            );
                          },
                          icon: Icon(FontAwesomeIcons.pen,
                              size: 20, color: lightColor)),
                    ))
              ],
            ),
            SizedBox(height: 20.h),
            TextFieldWidget(
                displayNameController, 'Nom et prénom', displayNameError),
            SizedBox(height: 30.h),
            ButtonWidget(updateProfile, 'Modifier', isLoading),
          ],
        ),
      ),
    );
  }

  takephoto(ImageSource source) async {
    final pick = await imagePicker.pickImage(source: source);
    setState(() {
      if (pick != null) {
        setState(() {
          photo = File(pick.path);
        });
      }
    });
  }

  Future<void> updateProfile() async {
    if (displayNameController.text == "") {
      setState(() {
        displayNameError = "Ce champ est obligatoire";
      });
    } else {
      setState(() {
        isLoading = true;
        displayNameError = "";
      });
      try {
        await context
            .read<UserProvider>()
            .updateProfile(displayNameController.text, photo)
            .then((value) {
          showDialog(
            context: context,
            builder: ((context) {
              return ErrorPopUp("Succès",
                  "Votre profil a été modifier avec succès", greenColor);
            }),
          );
        });
      } catch (onError) {
        showDialog(
          context: context,
          builder: ((context) {
            return ErrorPopUp("Alert", onError.toString(), redColor);
          }),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
