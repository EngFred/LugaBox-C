sealed class PersonDetailsEvent {
  const PersonDetailsEvent();
}

class PersonDetailsStarted extends PersonDetailsEvent {
  const PersonDetailsStarted(this.id);

  final int id;
}
