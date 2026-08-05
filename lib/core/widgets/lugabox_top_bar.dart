import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import 'lugabox_logo.dart';
import 'profile_menu_button.dart';

class LugaBoxTopBar extends StatelessWidget {
  const LugaBoxTopBar({super.key});

  static const height = 86.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(27, 18, 18, 20),
          child: Row(
            children: [
              const Expanded(child: LugaBoxLogo(size: 19)),
              IconButton(
                onPressed: () => context.push('/search'),
                icon: const Icon(Icons.search_rounded, size: 29),
                color: AppColors.white,
              ),
              IconButton(
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: 'Cast feature is not implemented yet',
                    backgroundColor: AppColors.surface,
                    textColor: AppColors.white,
                  );
                },
                icon: const Icon(Icons.cast_rounded, size: 27),
                color: AppColors.white,
              ),
              const ProfileMenuButton(),
            ],
          ),
        ),
      ),
    );
  }
}
