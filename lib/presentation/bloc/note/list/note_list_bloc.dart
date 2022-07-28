import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/domain/model/domain_note.dart';
import 'package:realm_notes/domain/watch_notes_use_case.dart';

part 'note_list_event.dart';

part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final WatchNotesUseCase _watchNotes;

  NoteListBloc({
    required WatchNotesUseCase watchNotes,
  })  : _watchNotes = watchNotes,
        super(
          const NoteListState(notes: [], grid: false),
        ) {
    on<NoteListInit>(
      (event, emit) {
        emit(state.copyWith(loading: true));

        return emit.forEach(
          _watchNotes.execute(),
          onData: (List<Notes> notes) {
            final domainNotes =
                notes.map((e) => DomainNote.fromNotes(e)).toList();
            return state.copyWith(notes: domainNotes, loading: false);
          },
        );
      },
    );

    on<NoteListChangeLayout>(
      (event, emit) => emit(state.copyWith(grid: !state.grid)),
      transformer: droppable(),
    );
  }
}
