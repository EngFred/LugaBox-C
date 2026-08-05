import '../../domain/entities/discover_feed.dart';

class DiscoverState {
  const DiscoverState({this.feed, this.isLoading = false, this.errorMessage});

  final DiscoverFeed? feed;
  final bool isLoading;
  final String? errorMessage;

  DiscoverState copyWith({
    DiscoverFeed? feed,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DiscoverState(
      feed: feed ?? this.feed,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
