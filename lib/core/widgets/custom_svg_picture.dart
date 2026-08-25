import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    this.withColorFilter = true,
    required this.path,
    this.width,
    this.height,
  });

  final bool withColorFilter;
  final String path;
  final double? width;

  final double? height;

  const CustomSvgPicture.withoutColor({
    super.key,
    required this.path,
    this.width,
    this.height,
  }) : withColorFilter = false;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      colorFilter: withColorFilter
          ? ColorFilter.mode(
              Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            )
          : null,
      width: width,
      height: height,
    );
  }
}
