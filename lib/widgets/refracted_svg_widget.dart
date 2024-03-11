import 'package:downloadeble_videoplayer/constents/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RefractedSvgWidgte extends StatelessWidget {
  const RefractedSvgWidgte({
    Key? key,
    required this.svgPath,
    this.svgHeight,
    this.svgWidth,
    this.color,
    this.fit,
    this.isGiveColour = false,
  }) : super(key: key);

  final String svgPath;
  final double? svgHeight;
  final double? svgWidth;
  final Color? color;
  final BoxFit? fit;
  final bool isGiveColour;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      svgPath,
      color: isGiveColour ? AppColors.appMainColor : color,
      height: svgHeight,
      width: svgWidth,
      cacheColorFilter: true,
      fit: fit ?? BoxFit.cover,
    );
  }
}
