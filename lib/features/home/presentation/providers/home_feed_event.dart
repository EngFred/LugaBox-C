sealed class HomeFeedEvent {
  const HomeFeedEvent();
}

class HomeFeedStarted extends HomeFeedEvent {
  const HomeFeedStarted();
}

class HomeFeedRefreshRequested extends HomeFeedEvent {
  const HomeFeedRefreshRequested();
}

class HomeFeedSectionPageRequested extends HomeFeedEvent {
  const HomeFeedSectionPageRequested(this.sectionKey);

  final String sectionKey;
}
