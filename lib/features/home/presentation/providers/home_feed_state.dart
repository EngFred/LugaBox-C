import '../../domain/entities/movie_section.dart';

class HomeFeedState {
  const HomeFeedState({
    this.sections = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.errorMessage,
  });

  final List<MovieSection> sections;
  final bool isLoading;
  final bool isRefreshing;
  final String? errorMessage;

  bool get hasContent => sections.isNotEmpty;

  HomeFeedState copyWith({
    List<MovieSection>? sections,
    bool? isLoading,
    bool? isRefreshing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeFeedState(
      sections: sections ?? this.sections,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
