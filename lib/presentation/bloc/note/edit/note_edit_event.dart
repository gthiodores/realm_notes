part of 'note_edit_bloc.dart';

abstract class NoteEditEvent extends Equatable {
  const NoteEditEvent();
}

class NoteEditTitle extends NoteEditEvent {
  final String title;

  const NoteEditTitle({required this.title});

  @override
  List<Object?> get props => [title];
}

class NoteEditContent extends NoteEditEvent {
  final String content;

  const NoteEditContent({required this.content});

  @override
  List<Object?> get props => [content];
}

class NoteEditColour extends NoteEditEvent {
  final NoteColour? colour;

  const NoteEditColour({this.colour});

  @override
  List<Object?> get props => [colour];
}

class NoteEditConfirm extends NoteEditEvent {
  @override
  List<Object?> get props => [];
}

class NoteEditDelete extends NoteEditEvent {
  @override
  List<Object?> get props => [];
}
