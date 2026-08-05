import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/credit_person.dart';

class CastCrewSection extends StatefulWidget {
  const CastCrewSection({super.key, required this.cast, required this.crew});

  final List<CreditPerson> cast;
  final List<CreditPerson> crew;

  @override
  State<CastCrewSection> createState() => _CastCrewSectionState();
}

class _CastCrewSectionState extends State<CastCrewSection> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final people = switch (_selectedIndex) {
      0 => widget.cast,
      1 => widget.crew,
      _ => [...widget.cast, ...widget.crew],
    };

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(33, 0, 0, 41),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cast & Crew',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _TabButton(
                  label: 'Cast',
                  selected: _selectedIndex == 0,
                  onTap: () => _select(0),
                ),
                const SizedBox(width: 14),
                _TabButton(
                  label: 'Crew',
                  selected: _selectedIndex == 1,
                  onTap: () => _select(1),
                ),
                const SizedBox(width: 14),
                _TabButton(
                  label: 'All',
                  selected: _selectedIndex == 2,
                  onTap: () => _select(2),
                ),
              ],
            ),
            const SizedBox(height: 26),
            SizedBox(
              height: 138,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: people.length,
                separatorBuilder: (_, _) => const SizedBox(width: 24),
                itemBuilder: (context, index) {
                  final person = people[index];
                  return GestureDetector(
                    onTap: () => context.push('/person/${person.id}'),
                    child: SizedBox(
                      width: 108,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 48,
                            backgroundColor: AppColors.field,
                            backgroundImage: person.profileUrl.isEmpty
                                ? null
                                : NetworkImage(person.profileUrl),
                            child: person.profileUrl.isEmpty
                                ? const Icon(Icons.person, size: 38)
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            person.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.w900),
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
      ),
    );
  }

  void _select(int index) => setState(() => _selectedIndex = index);
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 101,
      height: 58,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: selected ? const Color(0xFF202534) : AppColors.field,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
