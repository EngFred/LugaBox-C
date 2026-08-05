import '../../../home/domain/entities/movie.dart';

class SearchState {
  const SearchState({
    this.query = '',
    this.filter = 'all',
    this.results = const [],
    this.recentSearches = const ['wings of dread'],
    this.page = 0,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  final String query;
  final String filter;
  final List<Movie> results;
  final List<String> recentSearches;
  final int page;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;

  bool get hasQuery => query.trim().isNotEmpty;

  SearchState copyWith({
    String? query,
    String? filter,
    List<Movie>? results,
    List<String>? recentSearches,
    int? page,
    bool? isLoading,
    bool? isLoadingMore,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SearchState(
      query: query ?? this.query,
      filter: filter ?? this.filter,
      results: results ?? this.results,
      recentSearches: recentSearches ?? this.recentSearches,
      page: page ?? this.page,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
