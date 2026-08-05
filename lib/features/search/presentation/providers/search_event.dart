sealed class SearchEvent {
  const SearchEvent();
}

class SearchQueryChanged extends SearchEvent {
  const SearchQueryChanged(this.query);

  final String query;
}

class SearchFilterChanged extends SearchEvent {
  const SearchFilterChanged(this.filter);

  final String filter;
}

class SearchNextPageRequested extends SearchEvent {
  const SearchNextPageRequested();
}

class SearchSubmitted extends SearchEvent {
  const SearchSubmitted(this.query);

  final String query;
}

class SearchCleared extends SearchEvent {
  const SearchCleared();
}

class RecentSearchesCleared extends SearchEvent {
  const RecentSearchesCleared();
}
