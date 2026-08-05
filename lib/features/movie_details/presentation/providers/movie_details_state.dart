import '../../domain/entities/movie_details.dart';

class MovieDetailsState {
  const MovieDetailsState({
    this.details,
    this.isLoading = false,
    this.errorMessage,
  });

  final MovieDetails? details;
  final bool isLoading;
  final String? errorMessage;

  MovieDetailsState copyWith({
    MovieDetails? details,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return MovieDetailsState(
      details: details ?? this.details,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
