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
        padding: const EdgeInsets.fromLTRB(33, 0, 33, 28),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 58,
              child: FilledButton.icon(
                onPressed: details.trailer == null
                    ? null
                    : () => _openTrailer(context),
                icon: const Icon(Icons.play_arrow_rounded, size: 28),
                label: const Text('Play'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.red,
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: FilledButton.icon(
                onPressed: details.trailer == null
                    ? null
                    : () => _openTrailer(context),
                icon: const Icon(Icons.ondemand_video_rounded, size: 25),
                label: const Text('Watch Trailer'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.field,
                  foregroundColor: AppColors.white,
                  disabledBackgroundColor: AppColors.field,
                  disabledForegroundColor: AppColors.muted,
                  textStyle: const TextStyle(
                    fontSize: 18,
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

  void _openTrailer(BuildContext context) {
    context.push(
      '/trailer/${Uri.encodeComponent(details.title)}/${details.trailer!.key}',
    );
  }
}
