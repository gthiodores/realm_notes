import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/data/repository/notes_repository.dart';

class DeleteNoteUseCase {
  final INotesRepository _repository;

  const DeleteNoteUseCase(this._repository);

  Future<void> execute({required Notes toDelete}) => _repository.removeNote(
        toDelete: toDelete,
      );
}
