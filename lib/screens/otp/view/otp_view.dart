import 'package:downloadeble_videoplayer/constents/app_colors.dart';
import 'package:downloadeble_videoplayer/screens/otp/viewmodel/otp_provider.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_button_widget.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpProvider>(builder: (context, otpPro, _) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Column(
                children: [
                  RefractedTextWidget(
                    text: "Enter the OTP recieved",
                    textWeight: FontWeight.w600,
                    textSize: 18,
                  ),
                  RefractedTextWidget(
                    text: "on your phone number",
                    textWeight: FontWeight.w600,
                    textSize: 18,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                child: Pinput(
                  keyboardType: TextInputType.number,
                  listenForMultipleSmsOnAndroid: true,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  mainAxisAlignment: MainAxisAlignment.center,

                  // enableActiveFill: true,
                  defaultPinTheme: PinTheme(
                    width: 40.w,
                    height: 50.h,
                    textStyle: TextStyle(
                        fontSize: 20.sp,
                        color: const Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      color: AppColors.appMainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  length: 6,
                  onCompleted: (value) async {},
                  onChanged: (value) {
                    otpPro.getEneterOtp(value: value);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 65.w),
                child: const RefractedButtonWidget(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: RefractedButtonWidget(
                  radius: 10.r,
                  isEditting: false,
                  onPressed: () {
                    otpPro.onVerifyOtp();
                  },
                  child: const RefractedTextWidget(
                    text: 'Verify',
                    textSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RefractedTextWidget(
                      text: "Didn't  get any OTP?  ",
                      textWeight: FontWeight.bold,
                    ),
                    // Consumer<OtpVerifingProvider>(
                    //     builder: (context, otpVerifyProvider, _) {
                    //   if (otpVerifyProvider.start == 0) {
                    //     return
                    //   } else {
                    //     return RefractedTextWidget(
                    //       text:
                    //           "00:${otpVerifyProvider.start < 10 ? "0${otpVerifyProvider.start}" : otpVerifyProvider.start}sec",
                    //       textColor: AppColors.appColor,
                    //       textWeight: FontWeight.w600,
                    //     );
                    //   }
                    // })

                    GestureDetector(
                      onTap: () {},
                      child: const RefractedTextWidget(
                        text: "Resent OTP",
                        textColor: AppColors.appMainColor,
                        textWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
