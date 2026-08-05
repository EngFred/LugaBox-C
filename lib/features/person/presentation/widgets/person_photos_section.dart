import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/person_photo.dart';

class PersonPhotosSection extends StatelessWidget {
  const PersonPhotosSection({super.key, required this.photos});

  final List<PersonPhoto> photos;

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 33),
              child: Text(
                'Photos',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 27),
            SizedBox(
              height: 253,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                separatorBuilder: (_, _) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AspectRatio(
                      aspectRatio: .72,
                      child: Image.network(
                        photos[index].url,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            const ColoredBox(color: AppColors.field),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
