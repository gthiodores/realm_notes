part of 'note_list_bloc.dart';

abstract class NoteListEvent extends Equatable {
  const NoteListEvent();
}

class NoteListInit extends NoteListEvent {
  @override
  List<Object?> get props => [];
}

class NoteListChangeLayout extends NoteListEvent {
  @override
  List<Object?> get props => [];
}
