import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/movie_details_event.dart';
import '../providers/movie_details_providers.dart';
import '../widgets/cast_crew_section.dart';
import '../widgets/details_actions.dart';
import '../widgets/details_hero.dart';
import '../widgets/details_movie_row.dart';
import '../widgets/more_details_section.dart';
import '../widgets/seasons_section.dart';
import '../widgets/storyline_section.dart';
import '../widgets/tags_section.dart';

class MovieDetailsPage extends ConsumerStatefulWidget {
  const MovieDetailsPage({
    super.key,
    required this.mediaType,
    required this.id,
  });

  final String mediaType;
  final int id;

  @override
  ConsumerState<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends ConsumerState<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(movieDetailsNotifierProvider.notifier)
          .onEvent(
            MovieDetailsStarted(mediaType: widget.mediaType, id: widget.id),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(movieDetailsNotifierProvider);
    final details = state.details;

    if (state.isLoading && details == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.red)),
      );
    }

    if (details == null) {
      return Scaffold(
        body: Center(
          child: Text(
            state.errorMessage ?? 'Title not found.',
            style: const TextStyle(color: AppColors.muted),
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          DetailsHero(details: details),
          DetailsActions(details: details),
          StorylineSection(storyline: details.overview),
          CastCrewSection(cast: details.cast, crew: details.crew),
          SeasonsSection(details: details),
          MoreDetailsSection(details: details),
          TagsSection(genres: details.genres, tags: details.tags),
          DetailsMovieRow(
            title: 'Recommended on LugaBox',
            movies: details.recommendations,
          ),
          DetailsMovieRow(
            title: 'Similar Titles',
            movies: details.similarTitles,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
