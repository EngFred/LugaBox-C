import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_genre_movies.dart';
import '../../domain/usecases/get_vj_movies.dart';
import 'title_listing_event.dart';
import 'title_listing_state.dart';
import 'vjs_genres_dependencies.dart';

class TitleListingNotifier extends Notifier<TitleListingState> {
  late final GetGenreMovies _getGenreMovies;
  late final GetVjMovies _getVjMovies;
  TitleListingArgs? _args;

  @override
  TitleListingState build() {
    _getGenreMovies = ref.watch(getGenreMoviesProvider);
    _getVjMovies = ref.watch(getVjMoviesProvider);
    return const TitleListingState();
  }

  Future<void> onEvent(TitleListingEvent event) {
    return switch (event) {
      TitleListingStarted(:final args) => _start(args),
      TitleListingNextPageRequested() => _loadNextPage(),
    };
  }

  Future<void> _start(TitleListingArgs args) async {
    if (_args?.key == args.key && state.hasMovies) return;

    _args = args;
    state = const TitleListingState(isLoading: true);
    await _loadPage(1);
  }

  Future<void> _loadNextPage() async {
    if (state.isLoading || state.isLoadingMore || _args == null) return;

    state = state.copyWith(isLoadingMore: true, clearError: true);
    await _loadPage(state.page + 1, append: true);
  }

  Future<void> _loadPage(int page, {bool append = false}) async {
    final args = _args;
    if (args == null) return;

    try {
      final movies = switch (args.type) {
        TitleListingType.genre => await _getGenreMovies(
          genreId: args.id!,
          page: page,
        ),
        TitleListingType.vj => await _getVjMovies(
          vjName: args.vjName!,
          page: page,
        ),
      };

      state = state.copyWith(
        movies: append ? [...state.movies, ...movies] : movies,
        page: page,
        isLoading: false,
        isLoadingMore: false,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorMessage: error.toString(),
      );
    }
  }
}
