import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/data/repository/notes_repository.dart';

class EditNoteUseCase {
  final INotesRepository _repository;

  const EditNoteUseCase(this._repository);

  Future<void> execute({
    required Notes originalNote,
    required String title,
    required String content,
    required int? color,
  }) =>
      _repository.updateNote(
        originalNote: originalNote,
        title: title,
        content: content,
        color: color,
      );
}
