import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/search_titles.dart';
import 'search_dependencies.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchNotifier extends Notifier<SearchState> {
  late final SearchTitles _searchTitles;
  Timer? _debounce;

  @override
  SearchState build() {
    ref.onDispose(() => _debounce?.cancel());
    _searchTitles = ref.watch(searchTitlesProvider);
    return const SearchState();
  }

  Future<void> onEvent(SearchEvent event) {
    return switch (event) {
      SearchQueryChanged(:final query) => _queryChanged(query),
      SearchFilterChanged(:final filter) => _filterChanged(filter),
      SearchNextPageRequested() => _loadNextPage(),
      SearchSubmitted(:final query) => _submit(query),
      SearchCleared() => _clear(),
      RecentSearchesCleared() => _clearRecent(),
    };
  }

  Future<void> _queryChanged(String query) async {
    state = state.copyWith(query: query, clearError: true);
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 450), () {
      if (state.query.trim().isNotEmpty) _loadFirstPage();
    });
  }

  Future<void> _filterChanged(String filter) async {
    state = state.copyWith(filter: filter, clearError: true);
    if (state.hasQuery) await _loadFirstPage();
  }

  Future<void> _submit(String query) async {
    final value = query.trim();
    if (value.isEmpty) return;

    final recent = [
      value,
      ...state.recentSearches.where((item) => item != value),
    ].take(5).toList();
    state = state.copyWith(query: value, recentSearches: recent);
    await _loadFirstPage();
  }

  Future<void> _loadFirstPage() async {
    state = state.copyWith(
      isLoading: true,
      results: [],
      page: 0,
      clearError: true,
    );
    await _loadPage(1);
  }

  Future<void> _loadNextPage() async {
    if (!state.hasQuery || state.isLoading || state.isLoadingMore) return;
    state = state.copyWith(isLoadingMore: true, clearError: true);
    await _loadPage(state.page + 1, append: true);
  }

  Future<void> _loadPage(int page, {bool append = false}) async {
    try {
      final results = await _searchTitles(
        query: state.query.trim(),
        filter: state.filter,
        page: page,
      );
      state = state.copyWith(
        results: append ? [...state.results, ...results] : results,
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

  Future<void> _clear() async {
    _debounce?.cancel();
    state = state.copyWith(query: '', results: [], page: 0, clearError: true);
  }

  Future<void> _clearRecent() async {
    state = state.copyWith(recentSearches: []);
  }
}
