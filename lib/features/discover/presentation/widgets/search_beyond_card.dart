import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';

class SearchBeyondCard extends StatelessWidget {
  const SearchBeyondCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 18, 0, 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(33, 36, 33, 50),
        decoration: const BoxDecoration(
          color: Color(0xFF111111),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search beyond LugaBox',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 18),
            const Text(
              'Explore millions of titles and people from across the globe.',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 31),
            GestureDetector(
              onTap: () => context.push('/search'),
              child: Container(
                height: 75,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.public_rounded, color: AppColors.red, size: 31),
                    SizedBox(width: 22),
                    Text(
                      'Type a title or name...',
                      style: TextStyle(
                        color: Color(0xFF5F5F5F),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 33),
            const Row(
              children: [
                _SearchFilter(label: 'All', selected: true),
                SizedBox(width: 13),
                _SearchFilter(label: 'Movies'),
                SizedBox(width: 13),
                _SearchFilter(label: 'Series'),
                SizedBox(width: 13),
                _SearchFilter(label: 'People'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchFilter extends StatelessWidget {
  const _SearchFilter({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 51,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.red : const Color(0xFF211818),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.red : Color(0xFF503333),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
