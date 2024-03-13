import 'package:country_code_picker/country_code_picker.dart';
import 'package:downloadeble_videoplayer/constents/app_colors.dart';
import 'package:downloadeble_videoplayer/screens/login/viewmodel/login_provider.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_button_widget.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_text_widget.dart';
import 'package:downloadeble_videoplayer/widgets/reracted_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, loginPro, _) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // InkWell(
              //   onTap: () => isCurrentLanArabic()
              //       ? Get.updateLocale(const Locale('en_US'))
              //       : Get.updateLocale(const Locale('ar_SA')),
              //   child: SafeArea(
              //     child: RefractedTextWidget(
              //       text: isCurrentLanArabic() ? "English" : "عربي",
              //       textColor: AppColors.appWhite,
              //     ),
              //   ),
              // ),
              const RefractedTextWidget(
                text: 'Enter Your\nPhone Number',
                textSize: 24,
                textColor: AppColors.appMainColor,
                textWeight: FontWeight.bold,
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 45.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RefractedTextWidget(
                      text: 'Phone Number',
                      isSubText: true,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: RefractedTextFormFieldWidget(
                        controller: loginPro.numberCtr,
                        isShowHint: false,
                        keyboardtype: TextInputType.number,
                        contentPadding: EdgeInsets.zero,
                        perfixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CountryCodePicker(
                              padding: EdgeInsets.zero,
                              barrierColor: Colors.transparent,
                              showFlagMain: false,
                              textStyle: TextStyle(
                                  color: AppColors.appBlack,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp),
                              onChanged: (value) {
                                loginPro.getConuntryCode(value: value);
                              },
                              initialSelection: '+91',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: RefractedButtonWidget(
                        radius: 10.r,
                        isEditting: false,
                        onPressed: () async {
                          loginPro.onLogin(context);
                        },
                        child: const RefractedTextWidget(
                          text: 'Login',
                          textSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
