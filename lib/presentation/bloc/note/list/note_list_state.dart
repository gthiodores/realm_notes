part of 'note_list_bloc.dart';

class NoteListState extends Equatable {
  final bool grid;
  final bool loading;
  final List<Notes> notes;
  final Notes? deleted;
  final String? message;

  const NoteListState({
    required this.notes,
    this.grid = false,
    this.loading = false,
    this.deleted,
    this.message,
  });

  NoteListState copyWith({
    bool? grid,
    bool? loading,
    List<Notes>? notes,
    Notes? deleted,
    String? message,
  }) =>
      NoteListState(
        notes: notes ?? this.notes,
        grid: grid ?? false,
        loading: loading ?? this.loading,
        deleted: deleted,
        message: message,
      );

  @override
  List<Object?> get props => [grid, notes, loading, deleted, message];
}
