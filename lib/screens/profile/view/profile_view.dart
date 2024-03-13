import 'package:downloadeble_videoplayer/constents/app_colors.dart';
import 'package:downloadeble_videoplayer/screens/profile/viewmodel/profile_provider.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_button_widget.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_text_widget.dart';
import 'package:downloadeble_videoplayer/widgets/reracted_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, profilePro, _) {
      return Scaffold(
        appBar: AppBar(
          title: const RefractedTextWidget(
            text: 'Profile',
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Form(
              key: profilePro.formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () => profilePro.takeImage(),
                    child: Container(
                      height: 80.h,
                      width: 80.h,
                      decoration: BoxDecoration(
                          image: profilePro.fileImage != null
                              ? DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: FileImage(profilePro.fileImage!))
                              : null,
                          shape: BoxShape.circle,
                          color: AppColors.appGrey),
                      child: const Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  RefractedTextFormFieldWidget(
                    controller: profilePro.nameCtr,
                    hinttext: 'Name',
                    alignLabelWithHint: true,
                  ),
                  RefractedTextFormFieldWidget(
                    controller: profilePro.emailCtr,
                    hinttext: 'Email',
                    alignLabelWithHint: true,
                  ),
                  RefractedTextFormFieldWidget(
                    controller: profilePro.dobCtr,
                    hinttext: 'DOB',
                    alignLabelWithHint: true,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: RefractedButtonWidget(
                      radius: 10.r,
                      isEditting: false,
                      onPressed: () async {
                        profilePro.saveUserData();
                      },
                      child: const RefractedTextWidget(
                        text: 'Save',
                        textSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
