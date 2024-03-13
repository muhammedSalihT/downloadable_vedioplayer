import 'package:downloadeble_videoplayer/constents/app_colors.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RefractedTextFormFieldWidget extends StatelessWidget {
  const RefractedTextFormFieldWidget(
      {Key? key,
      this.hinttext,
      this.controller,
      this.keyboardtype,
      this.isValidating = true,
      this.isEmailValidation = false,
      this.isPassValidation = false,
      this.isConfPassValidation = false,
      this.maxLines = 1,
      this.validation,
      this.onTap,
      this.readOnly = false,
      this.edgeInsect,
      this.fontSize,
      this.enabled,
      this.initialValue,
      this.autofocus = false,
      this.fillColor,
      this.focusNode,
      this.perfixIcon,
      this.formFieldSuffixIcon,
      this.customBorder,
      this.onChanged,
      this.headingText,
      this.textFieldHeight,
      this.textAlign = TextAlign.start,
      this.labelText,
      this.contentPadding,
      this.isDense,
      this.hintColor,
      this.borderRadius,
      this.hintStyle,
      this.label,
      this.alignLabelWithHint = false,
      this.currentPass,
      this.newPass,
      this.isShowHint = true,
      this.textColor})
      : super(key: key);

  final String? hinttext;
  final TextEditingController? controller;
  final TextInputType? keyboardtype;
  final bool? isValidating;
  final int? maxLines;
  final String? Function(String?)? validation;
  final void Function()? onTap;
  final bool? readOnly;
  final EdgeInsetsGeometry? edgeInsect;
  final double? fontSize;
  final bool? enabled;
  final String? initialValue;
  final bool? isEmailValidation;
  final bool? isConfPassValidation;
  final Color? fillColor;
  final Color? textColor;
  final Color? hintColor;
  final bool autofocus;
  final FocusNode? focusNode;
  final Widget? perfixIcon;
  final Widget? formFieldSuffixIcon;
  final InputBorder? customBorder;
  final void Function(String)? onChanged;
  final String? headingText;
  final double? textFieldHeight;
  final TextAlign textAlign;
  final String? labelText;
  final EdgeInsetsGeometry? contentPadding;
  final bool? isDense;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final Widget? label;
  final bool alignLabelWithHint;
  final bool isPassValidation;
  final String? currentPass;
  final String? newPass;
  final bool isShowHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headingText != null)
          Padding(
            padding: EdgeInsets.only(left: 10.w, bottom: 2.h),
            child: RefractedTextWidget(
              text: headingText ?? '',
              textSize: 15,
            ),
          ),
        Padding(
          padding: edgeInsect ??
              EdgeInsets.only(
                // left: 10.w,
                // right: 10.w,
                bottom: 15.h,
              ),
          child: SizedBox(
            height: textFieldHeight,
            child: TextFormField(
              textAlign: textAlign,
              autofocus: autofocus,
              initialValue: initialValue,
              style: TextStyle(
                  fontSize: fontSize?.sp ?? 18.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor),
              readOnly: readOnly!,
              enabled: enabled,
              focusNode: focusNode,
              onTap: onTap,
              onChanged: onChanged,
              maxLines: maxLines,
              keyboardType: keyboardtype,
              controller: controller,
              validator: validation ??
                  (isValidating!
                      ? (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter ${hinttext ?? headingText}";
                          }
                          return null;
                        }
                      : (value) => null),
              decoration: InputDecoration(
                alignLabelWithHint: alignLabelWithHint,
                label: label,

                isDense: isDense ?? true,
                labelText: hinttext,
                // alignLabelWithHint: true,
                suffixIcon: formFieldSuffixIcon,
                prefixIcon: perfixIcon,
                contentPadding: contentPadding ??
                    EdgeInsets.fromLTRB(12.w, 16.h, 5.w, 16.h),
                fillColor: fillColor ?? Colors.transparent,
                filled: true,
                hintText: isShowHint ? hinttext : '',
                hintStyle: hintStyle ??
                    TextStyle(
                        fontSize: fontSize?.sp ?? 18.sp, color: hintColor),
                border: customBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
                      borderSide:
                          const BorderSide(color: AppColors.appMainColor),
                    ),
                disabledBorder: customBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: AppColors.appMainColor),
                    ),
                enabledBorder: customBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
                      borderSide:
                          const BorderSide(color: AppColors.appMainColor),
                    ),
                focusedErrorBorder: customBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                errorBorder: customBorder ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                focusedBorder: readOnly!
                    ? customBorder ??
                        OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(borderRadius ?? 15.r),
                            borderSide:
                                const BorderSide(color: AppColors.appMainColor))
                    : customBorder ??
                        OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(borderRadius ?? 15.r),
                            borderSide: const BorderSide(
                                color: AppColors.appMainColor)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
