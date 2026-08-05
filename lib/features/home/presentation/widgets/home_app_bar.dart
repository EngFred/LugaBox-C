import 'package:flutter/material.dart';

import '../../../../core/widgets/lugabox_top_bar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: LugaBoxTopBar());
  }
}
