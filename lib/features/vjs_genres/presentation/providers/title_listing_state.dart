import '../../../home/domain/entities/movie.dart';

enum TitleListingType { genre, vj }

class TitleListingArgs {
  const TitleListingArgs.genre({required this.id, required this.title})
    : type = TitleListingType.genre,
      vjName = null;

  const TitleListingArgs.vj({required String vjName})
    : type = TitleListingType.vj,
      id = null,
      title = vjName,
      vjName = vjName;

  final TitleListingType type;
  final int? id;
  final String title;
  final String? vjName;

  String get key => switch (type) {
    TitleListingType.genre => 'genre-$id',
    TitleListingType.vj => 'vj-$vjName',
  };
}

class TitleListingState {
  const TitleListingState({
    this.movies = const [],
    this.page = 0,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  final List<Movie> movies;
  final int page;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;

  bool get hasMovies => movies.isNotEmpty;

  TitleListingState copyWith({
    List<Movie>? movies,
    int? page,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TitleListingState(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
