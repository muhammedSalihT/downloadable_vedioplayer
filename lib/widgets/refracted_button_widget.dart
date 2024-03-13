import 'package:downloadeble_videoplayer/constents/app_colors.dart';
import 'package:downloadeble_videoplayer/utils/refracted_util_widgets.dart';
import 'package:downloadeble_videoplayer/widgets/refracted_text_widget.dart';
import 'package:flutter/material.dart';

class RefractedButtonWidget extends StatelessWidget {
  const RefractedButtonWidget(
      {Key? key,
      this.color,
      this.onPressed,
      this.child,
      this.radius,
      this.borderColor,
      this.buttonHeight,
      this.buttonWidth,
      this.padding,
      this.isCircle = false,
      this.splashColor,
      this.isEditting = false,
      this.onLongPress,
      this.buttonText,
      this.shadowColor,
      this.boxShadow,
      this.buttonTextColor})
      : super(key: key);

  final Color? color;
  final Function()? onPressed;
  final Widget? child;
  final double? radius;
  final Color? borderColor;
  final double? buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsGeometry? padding;
  final bool? isCircle;
  final Color? splashColor;
  final Function()? onLongPress;
  final bool isEditting;
  final String? buttonText;
  final Color? shadowColor;
  final List<BoxShadow>? boxShadow;
  final Color? buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: shadowColor,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius ?? 8),
      elevation: shadowColor == null ? 0 : 5,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 8),
            boxShadow: boxShadow),
        child: MaterialButton(
          onLongPress: onLongPress,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          disabledColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: splashColor,
          focusElevation: 0,
          hoverElevation: 0,
          disabledElevation: 0,
          highlightElevation: 0,
          padding: padding ?? const EdgeInsets.all(15),
          shape: isCircle == true
              ? CircleBorder(
                  side: BorderSide(color: borderColor ?? Colors.transparent))
              : RoundedRectangleBorder(
                  side: BorderSide(
                    color: borderColor ?? Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(radius ?? 8)),
          color: color ?? AppColors.appMainColor,
          elevation: 0,
          height: buttonHeight,
          minWidth: buttonWidth ?? double.infinity,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: onPressed,
          child: isEditting
              ? UtilWidgets.refractedLoadingWidget()
              : child ??
                  RefractedTextWidget(
                    isSubText: true,
                    textSize: 18,
                    text: buttonText ?? '',
                    textColor: buttonTextColor ?? Colors.black,
                  ),
        ),
      ),
    );
  }
}
