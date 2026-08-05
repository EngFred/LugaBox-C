import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/discover_person.dart';

class DiscoverPeopleRow extends StatelessWidget {
  const DiscoverPeopleRow({
    super.key,
    required this.title,
    required this.people,
  });

  final String title;
  final List<DiscoverPerson> people;

  @override
  Widget build(BuildContext context) {
    if (people.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              title,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 190,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              scrollDirection: Axis.horizontal,
              itemCount: people.length,
              separatorBuilder: (_, _) => const SizedBox(width: 28),
              itemBuilder: (context, index) {
                final person = people[index];
                return GestureDetector(
                  onTap: () => context.push('/person/${person.id}'),
                  child: SizedBox(
                    width: 130,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(65),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(
                              person.profileUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) =>
                                  const ColoredBox(color: AppColors.field),
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Text(
                          person.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
