import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RefractedTextWidget extends StatelessWidget {
  const RefractedTextWidget({
    Key? key,
    required this.text,
    this.textSize,
    this.textColor,
    this.textWeight,
    this.onTap,
    this.maxLines,
    this.align,
    this.overflow = TextOverflow.ellipsis,
    this.decoration,
    this.isSubText = false,
    this.fontFamily,
  }) : super(key: key);

  final bool isSubText;
  final String text;
  final double? textSize;
  final Color? textColor;
  final FontWeight? textWeight;
  final VoidCallback? onTap;
  final int? maxLines;
  final TextAlign? align;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        color: Colors.transparent,
        child: Text(
          text,
          maxLines: maxLines,
          textAlign: align ?? TextAlign.start,
          overflow: overflow,
          style: TextStyle(
              fontFamily: fontFamily,
              decoration: decoration,
              color: textColor ?? Colors.black,
              // ignore: prefer_if_null_operators
              fontSize: textSize != null
                  ? textSize?.sp
                  : isSubText == false
                      ? 20.sp
                      : 18.sp,
              // ignore: prefer_if_null_operators
              fontWeight: textWeight == null
                  ? isSubText == true
                      ? FontWeight.w500
                      : FontWeight.bold
                  : textWeight),
        ),
      ),
    );
  }
}
