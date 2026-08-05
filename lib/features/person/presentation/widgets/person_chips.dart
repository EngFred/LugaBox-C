import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/person_details.dart';

class PersonChips extends StatelessWidget {
  const PersonChips({super.key, required this.person});

  final PersonDetails person;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(33, 0, 33, 35),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _Chip(label: person.knownForDepartment),
            _Chip(label: person.birthday),
            _Chip(label: person.placeOfBirth),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFD2D2D2),
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
