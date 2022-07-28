import 'package:realm_notes/data/model/user.dart';
import 'package:realm_notes/data/repository/notes_repository.dart';

class SearchNoteUseCase {
  final INotesRepository _repository;

  const SearchNoteUseCase(this._repository);

  Future<List<Notes>> execute(String searchQuery) => _repository.searchNotes(
        title: searchQuery,
      );
}
