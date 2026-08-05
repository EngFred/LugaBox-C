import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class LugaBoxLogo extends StatelessWidget {
  const LugaBoxLogo({super.key, this.size = 22, this.centered = false});

  final double size;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final logo = RichText(
      text: TextSpan(
        style: TextStyle(
          color: AppColors.white,
          fontSize: size,
          fontWeight: FontWeight.w900,
          height: 1,
        ),
        children: const [
          TextSpan(text: 'Luga'),
          TextSpan(
            text: 'Box',
            style: TextStyle(color: AppColors.red),
          ),
        ],
      ),
    );

    return SizedBox(
      width: centered ? double.infinity : null,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: centered ? Alignment.center : Alignment.centerLeft,
        children: [
          logo,
          Positioned(
            bottom: -8,
            left: centered ? null : size * .36,
            child: Container(
              width: size * 4.5,
              height: size * .12,
              decoration: const BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.all(Radius.circular(99)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
