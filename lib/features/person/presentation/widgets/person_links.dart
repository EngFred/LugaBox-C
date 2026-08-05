import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/person_details.dart';

class PersonLinks extends StatelessWidget {
  const PersonLinks({super.key, required this.person});

  final PersonDetails person;

  @override
  Widget build(BuildContext context) {
    final links = [
      if (person.imdbId != null)
        _Link('IMDB', 'https://www.imdb.com/name/${person.imdbId}/'),
      if (person.instagramId != null)
        _Link('Instagram', 'https://www.instagram.com/${person.instagramId}/'),
      if (person.facebookId != null)
        _Link('Facebook', 'https://www.facebook.com/${person.facebookId}/'),
    ];

    if (links.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(33, 0, 33, 47),
        child: Wrap(
          spacing: 16,
          runSpacing: 14,
          children: [
            for (final link in links)
              SizedBox(
                height: 57,
                child: OutlinedButton(
                  onPressed: () => launchUrl(
                    Uri.parse(link.url),
                    mode: LaunchMode.externalApplication,
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                  ),
                  child: Text(
                    link.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
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

class _Link {
  const _Link(this.label, this.url);

  final String label;
  final String url;
}
