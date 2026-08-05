import '../../domain/entities/genre.dart';
import '../../domain/entities/movie_section.dart';

class HomeFeedState {
  const HomeFeedState({
    this.sections = const [],
    this.genres = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.loadingSectionKeys = const {},
    this.sectionPages = const {},
    this.errorMessage,
  });

  final List<MovieSection> sections;
  final List<Genre> genres;
  final bool isLoading;
  final bool isRefreshing;
  final Set<String> loadingSectionKeys;
  final Map<String, int> sectionPages;
  final String? errorMessage;

  bool get hasContent => sections.isNotEmpty;

  HomeFeedState copyWith({
    List<MovieSection>? sections,
    List<Genre>? genres,
    bool? isLoading,
    bool? isRefreshing,
    Set<String>? loadingSectionKeys,
    Map<String, int>? sectionPages,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeFeedState(
      sections: sections ?? this.sections,
      genres: genres ?? this.genres,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      loadingSectionKeys: loadingSectionKeys ?? this.loadingSectionKeys,
      sectionPages: sectionPages ?? this.sectionPages,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
