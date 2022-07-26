import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/domain/add_note_use_case.dart';
import 'package:realm_notes/presentation/util/note_colour.dart';

part 'note_edit_event.dart';

part 'note_edit_state.dart';

class NoteEditBloc extends Bloc<NoteEditEvent, NoteEditState> {
  final AddNoteUseCase _addNote;

  NoteEditBloc(
    this._addNote, {
    Notes? note,
  }) : super(NoteEditState.initial(note)) {
    on<NoteEditTitle>((event, emit) {
      final changed = _calculateChangedStatus(
        title: event.title,
        content: state.content,
        colour: state.currentColour,
        note: note,
      );

      emit(state.copyWith(title: event.title, hasChanged: changed));
    });

    on<NoteEditContent>((event, emit) {
      final changed = _calculateChangedStatus(
        title: state.title,
        content: event.content,
        colour: state.currentColour,
        note: note,
      );
      emit(state.copyWith(content: event.content, hasChanged: changed));
    });

    on<NoteEditColour>((event, emit) {
      final changed = _calculateChangedStatus(
        title: state.title,
        content: state.content,
        colour: event.colour,
        note: note,
      );
      if (event.colour == null) {
        emit(state.removeColour(hasChanged: changed));
      } else {
        emit(state.copyWith(currentColour: event.colour, hasChanged: changed));
      }
    });

    on<NoteEditConfirm>((event, emit) async {
      final content = state.content;
      final title = state.title;

      if (content.isEmpty && title.isEmpty) {
        emit(state.copyWith(shouldNavigateBack: true));
        return;
      }

      await _addNote.execute(
        title: title,
        content: content,
        color: state.currentColour?.index,
      );

      emit(state.copyWith(shouldNavigateBack: true));
    });
  }

  bool _calculateChangedStatus({
    required String title,
    required String content,
    required NoteColour? colour,
    required Notes? note,
  }) {
    final titleIsEqual = title == (note?.title ?? '');
    final contentIsEqual = content == (note?.content ?? '');
    final colourIsEqual = colour?.index == note?.color;

    return !(titleIsEqual && contentIsEqual && colourIsEqual);
  }
}
