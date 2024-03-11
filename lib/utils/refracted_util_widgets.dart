import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:downloadeble_videoplayer/constents/app_colors.dart';
import 'package:downloadeble_videoplayer/utils/app_navigation.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/refracted_text_widget.dart';

class UtilWidgets {
  static Border utilBorderWidget() {
    return const Border(
        bottom: BorderSide(color: AppColors.appMainColor, width: .2));
  }

  static Container refractedLoadingWidget(
      {double? width, double? height, double? radius, Color? color}) {
    return Container(
        height: height ?? 22,
        width: width ?? 22,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: color ?? AppColors.appMainColor,
        ));
  }

  static getToast({String? showText, int? milliseconds}) {
    BotToast.showText(
      enableKeyboardSafeArea: false,
      backButtonBehavior: BackButtonBehavior.close,
      // align: Alignment(0, 2.1),
      clickClose: true,
      crossPage: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      contentColor: AppColors.appBlack,
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: AppColors.appMainColor),
      borderRadius: BorderRadius.circular(10),
      animationDuration: const Duration(milliseconds: 500),
      duration: Duration(milliseconds: milliseconds ?? 2000),
      text: showText.toString(),
    );
  }

  static Future<dynamic> refractedOpenDialogBox(
      {required BuildContext context,
      String? titleText,
      bool isLoading = false,
      void Function()? onTap}) {
    return showDialog(
        barrierColor: AppColors.appBlack.withOpacity(.8),
        barrierDismissible: isLoading ? false : true,
        context: context,
        builder: (builder) => Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 80.h, bottom: 60.h, left: 20.w, right: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const RefractedTextWidget(
                    text: 'CONGRATULATIONS',
                    textSize: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h, bottom: 50.h),
                    child: Column(
                      children: const [
                        RefractedTextWidget(
                          text: 'Your order has ben placed',
                          textSize: 18,
                          isSubText: true,
                          textWeight: FontWeight.w300,
                        ),
                        RefractedTextWidget(
                          text: 'successfully',
                          textSize: 18,
                          isSubText: true,
                          textWeight: FontWeight.w300,
                        ),
                        // Row(
                        //   children: [
                        //     RefractedTextWidget(
                        //       text: 'delivering ',
                        //       textSize: 18,
                        //       isSubText: true,
                        //       textWeight: FontWeight.w300,
                        //     ),
                        //     RefractedTextWidget(
                        //       text: 'TODAY',
                        //       textSize: 18,
                        //       isSubText: true,
                        //       textWeight: FontWeight.w300,
                        //       textColor: AppColors.appColor,
                        //     ),
                        //     RefractedTextWidget(
                        //       text: ' at ',
                        //       textSize: 18,
                        //       isSubText: true,
                        //       textWeight: FontWeight.w300,
                        //     ),
                        //     RefractedTextWidget(
                        //       text: '07:45 PM',
                        //       textSize: 18,
                        //       isSubText: true,
                        //       textWeight: FontWeight.w300,
                        //       textColor: AppColors.appColor,
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  RefractedButtonWidget(
                    buttonWidth: double.infinity,
                    onPressed: () {
                      AppNavigation.pop(context);
                    },
                    buttonText: 'Back to Home',
                  ),
                ],
              ),
            )));
  }

  static Widget refractedGridView(
      {required Widget? Function(BuildContext, int) itemBuilder,
      required int itmCount,
      EdgeInsetsGeometry? padding,
      double? childAspectRatio}) {
    return GridView.builder(
      padding: padding ?? EdgeInsets.only(bottom: 25.h),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: childAspectRatio ?? 1.w / 1.1.h,
          mainAxisSpacing: 15.h,
          crossAxisSpacing: 15.w,
          crossAxisCount: 2),
      itemBuilder: itemBuilder,
      itemCount: itmCount,
    );
  }

  static Widget refractedNetworkImageWidget({
    required String image,
    double? height,
    double? width,
  }) {
    return SizedBox(
      height: height?.h ?? 40.h,
      width: width?.w ?? 40.h,
      child: CachedNetworkImage(
        height: height?.h ?? 40.h,
        width: width?.w ?? 40.h,
        imageUrl: image,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return const Center(
            child: Icon(
              Icons.image,
              color: Colors.grey,
            ),
          );
        },
        placeholder: (
          context,
          url,
        ) =>
            const Center(
                child: CircularProgressIndicator(
          color: AppColors.appMainColor,
        )),
      ),
    );
  }
}
