import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/person_details_event.dart';
import '../providers/person_details_providers.dart';
import '../widgets/biography_section.dart';
import '../widgets/person_chips.dart';
import '../widgets/person_hero.dart';
import '../widgets/person_links.dart';
import '../widgets/person_photos_section.dart';
import '../../../movie_details/presentation/widgets/details_movie_row.dart';

class PersonDetailsPage extends ConsumerStatefulWidget {
  const PersonDetailsPage({super.key, required this.id});

  final int id;

  @override
  ConsumerState<PersonDetailsPage> createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends ConsumerState<PersonDetailsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(personDetailsNotifierProvider.notifier)
          .onEvent(PersonDetailsStarted(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(personDetailsNotifierProvider);
    final person = state.person;

    if (state.isLoading && person == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.red)),
      );
    }

    if (person == null) {
      return Scaffold(
        body: Center(
          child: Text(
            state.errorMessage ?? 'Actor not found.',
            style: const TextStyle(color: AppColors.muted),
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          PersonHero(person: person),
          PersonChips(person: person),
          BiographySection(biography: person.biography),
          PersonLinks(person: person),
          PersonPhotosSection(photos: person.photos),
          DetailsMovieRow(
            title: 'Movies & Shows',
            movies: person.knownForTitles,
          ),
        ],
      ),
    );
  }
}
