part of 'note_search_bloc.dart';

class NoteSearchState extends Equatable {
  final String searchQuery;
  final bool loading;
  final List<Notes> notes;

  const NoteSearchState({
    required this.searchQuery,
    required this.notes,
    required this.loading,
  });

  NoteSearchState.initial()
      : searchQuery = '',
        loading = false,
        notes = [];

  NoteSearchState copyWith({
    String? searchQuery,
    List<Notes>? notes,
    bool? loading,
  }) =>
      NoteSearchState(
        searchQuery: searchQuery ?? this.searchQuery,
        notes: notes ?? this.notes,
        loading: loading ?? this.loading,
      );

  @override
  List<Object?> get props => [searchQuery, notes, loading];
}
