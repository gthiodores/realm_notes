import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/domain/search_note_use_case.dart';
import 'package:rxdart/rxdart.dart';

part 'note_search_event.dart';

part 'note_search_state.dart';

class NoteSearchBloc extends Bloc<NoteSearchEvent, NoteSearchState> {
  final SearchNoteUseCase _searchNote;

  NoteSearchBloc({
    required SearchNoteUseCase searchNote,
  })  : _searchNote = searchNote,
        super(NoteSearchState.initial()) {
    on<NoteSearchQueryChanged>(
      (event, emit) async {
        emit(state.copyWith(loading: true));

        if (event.query.isEmpty) {
          emit(state.copyWith(searchQuery: '', notes: [], loading: false));
          return;
        }

        final notes = await _searchNote.execute(event.query);
        emit(state.copyWith(
          searchQuery: event.query,
          loading: false,
          notes: notes,
        ));
      },
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 100))
          .switchMap(mapper),
    );
  }
}
