import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_vjs_and_genres.dart';
import 'vjs_genres_dependencies.dart';
import 'vjs_genres_event.dart';
import 'vjs_genres_state.dart';

class VjsGenresNotifier extends Notifier<VjsGenresState> {
  late final GetVjsAndGenres _getVjsAndGenres;

  @override
  VjsGenresState build() {
    _getVjsAndGenres = ref.watch(getVjsAndGenresProvider);
    return const VjsGenresState();
  }

  Future<void> onEvent(VjsGenresEvent event) {
    return switch (event) {
      VjsGenresStarted() => _load(),
    };
  }

  Future<void> _load() async {
    if (state.isLoading || state.genres.isNotEmpty) return;

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final result = await _getVjsAndGenres();
      state = state.copyWith(
        vjs: result.vjs,
        genres: result.genres,
        isLoading: false,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
    }
  }
}
