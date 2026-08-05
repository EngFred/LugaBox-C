import 'title_listing_state.dart';

sealed class TitleListingEvent {
  const TitleListingEvent();
}

class TitleListingStarted extends TitleListingEvent {
  const TitleListingStarted(this.args);

  final TitleListingArgs args;
}

class TitleListingNextPageRequested extends TitleListingEvent {
  const TitleListingNextPageRequested();
}
