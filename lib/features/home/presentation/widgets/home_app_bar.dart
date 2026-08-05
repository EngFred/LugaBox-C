import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/lugabox_logo.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(27, 28, 18, 38),
        child: Row(
          children: [
            const Expanded(child: LugaBoxLogo(size: 19)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded, size: 31),
              color: AppColors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.cast_rounded, size: 29),
              color: AppColors.white,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded, size: 29),
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
