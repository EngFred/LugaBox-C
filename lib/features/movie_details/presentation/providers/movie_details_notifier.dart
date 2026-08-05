import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_movie_details.dart';
import 'movie_details_dependencies.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

class MovieDetailsNotifier extends Notifier<MovieDetailsState> {
  late final GetMovieDetails _getMovieDetails;

  @override
  MovieDetailsState build() {
    _getMovieDetails = ref.watch(getMovieDetailsProvider);
    return const MovieDetailsState();
  }

  Future<void> onEvent(MovieDetailsEvent event) {
    return switch (event) {
      MovieDetailsStarted(:final mediaType, :final id) => _load(mediaType, id),
    };
  }

  Future<void> _load(String mediaType, int id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final details = await _getMovieDetails(mediaType: mediaType, id: id);
      state = state.copyWith(
        details: details,
        isLoading: false,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
    }
  }
}
