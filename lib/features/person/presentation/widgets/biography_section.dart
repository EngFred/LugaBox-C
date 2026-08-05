import 'package:flutter/material.dart';

class BiographySection extends StatelessWidget {
  const BiographySection({super.key, required this.biography});

  final String biography;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(33, 0, 33, 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Biography',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 22),
            Text(
              biography.isEmpty ? 'Biography is not available yet.' : biography,
              style: const TextStyle(
                color: Color(0xFFC1C1C1),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.43,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
