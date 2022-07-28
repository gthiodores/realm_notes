part of 'note_edit_bloc.dart';

class NoteEditState extends Equatable {
  final Notes? note;
  final NoteColour? currentColour;
  final String title;
  final String content;
  final bool loading;
  final bool hasChanged;
  final bool shouldNavigateBack;

  const NoteEditState({
    required this.title,
    required this.content,
    this.note,
    this.currentColour,
    this.loading = false,
    this.shouldNavigateBack = false,
    this.hasChanged = false,
  });

  NoteEditState.initial(this.note)
      : currentColour =
            note?.color == null ? null : NoteColour.values[note!.color!],
        shouldNavigateBack = false,
        hasChanged = false,
        loading = false,
        title = note?.title ?? '',
        content = note?.content ?? '';

  NoteEditState copyWith({
    Notes? note,
    NoteColour? currentColour,
    String? title,
    String? content,
    bool? loading,
    bool? shouldNavigateBack,
    bool? hasChanged,
  }) =>
      NoteEditState(
        title: title ?? this.title,
        content: content ?? this.content,
        currentColour: currentColour ?? this.currentColour,
        shouldNavigateBack: shouldNavigateBack ?? false,
        note: note,
        loading: loading ?? false,
        hasChanged: hasChanged ?? this.hasChanged,
      );

  NoteEditState removeColour({bool hasChanged = false}) => NoteEditState(
        title: title,
        content: content,
        shouldNavigateBack: shouldNavigateBack,
        note: note,
        currentColour: null,
        hasChanged: hasChanged,
        loading: false,
      );

  @override
  List<Object?> get props => [
        title,
        content,
        note,
        currentColour,
        shouldNavigateBack,
        hasChanged,
        loading,
      ];
}
