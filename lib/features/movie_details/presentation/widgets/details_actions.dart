import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/movie_details.dart';

class DetailsActions extends StatelessWidget {
  const DetailsActions({super.key, required this.details});

  final MovieDetails details;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(33, 0, 33, 31),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 74,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow_rounded, size: 35),
                label: const Text('Play'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.red,
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 74,
              child: FilledButton.icon(
                onPressed: details.trailer == null
                    ? null
                    : () => context.push(
                        '/trailer/${Uri.encodeComponent(details.title)}/${details.trailer!.key}',
                      ),
                icon: const Icon(Icons.ondemand_video_rounded, size: 31),
                label: const Text('Watch Trailer'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.field,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.field,
                  disabledForegroundColor: AppColors.muted,
                  textStyle: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
