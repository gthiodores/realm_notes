import 'package:realm_notes/data/repository/notes_repository.dart';

class AddNoteUseCase {
  final INotesRepository _repository;

  const AddNoteUseCase({required INotesRepository repository})
      : _repository = repository;

  Future<void> execute({
    required String title,
    required String content,
    int? color,
  }) =>
      _repository.addNotes(title: title, content: content, color: color);
}
