part of 'note_search_bloc.dart';

abstract class NoteSearchEvent extends Equatable {
  const NoteSearchEvent();
}

class NoteSearchQueryChanged extends NoteSearchEvent {
  final String query;

  const NoteSearchQueryChanged({required this.query});

  @override
  List<Object?> get props => [query];
}
