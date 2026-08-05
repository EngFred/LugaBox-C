sealed class HomeFeedEvent {
  const HomeFeedEvent();
}

class HomeFeedStarted extends HomeFeedEvent {
  const HomeFeedStarted();
}

class HomeFeedRefreshRequested extends HomeFeedEvent {
  const HomeFeedRefreshRequested();
}
