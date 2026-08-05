import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/person_details.dart';

class PersonHero extends StatelessWidget {
  const PersonHero({super.key, required this.person});

  final PersonDetails person;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 500,
            child: Image.network(
              person.profileUrl,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              errorBuilder: (_, _, _) =>
                  const ColoredBox(color: AppColors.field),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: .03),
                    Colors.black.withValues(alpha: .1),
                    AppColors.black,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 13,
            child: IconButton(
              onPressed: context.pop,
              icon: const Icon(Icons.arrow_back, size: 31),
              color: Colors.white,
            ),
          ),
          Positioned(
            left: 33,
            right: 33,
            bottom: 22,
            child: Text(
              person.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w900,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
