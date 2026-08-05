sealed class MovieDetailsEvent {
  const MovieDetailsEvent();
}

class MovieDetailsStarted extends MovieDetailsEvent {
  const MovieDetailsStarted({required this.mediaType, required this.id});

  final String mediaType;
  final int id;
}
