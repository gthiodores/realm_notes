import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/data/repository/notes_repository.dart';

class WatchNotesUseCase {
  final INotesRepository _repository;

  const WatchNotesUseCase(this._repository);

  Stream<List<Notes>> execute() => _repository.watchNotes();
}
