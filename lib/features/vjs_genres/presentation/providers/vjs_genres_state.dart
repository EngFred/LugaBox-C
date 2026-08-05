import '../../../home/domain/entities/genre.dart';

class VjsGenresState {
  const VjsGenresState({
    this.vjs = const [],
    this.genres = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<String> vjs;
  final List<Genre> genres;
  final bool isLoading;
  final String? errorMessage;

  VjsGenresState copyWith({
    List<String>? vjs,
    List<Genre>? genres,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return VjsGenresState(
      vjs: vjs ?? this.vjs,
      genres: genres ?? this.genres,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
