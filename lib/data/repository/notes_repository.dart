import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:realm_notes/data/model/user.dart' as model;
import 'package:realm_notes/data/realm_container.dart';

abstract class INotesRepository {
  Stream<List<model.Notes>> watchNotes();

  Future<List<model.Notes>> searchNotes({required String title});

  Future<void> addNotes({
    required String title,
    required String content,
    required int color,
  });

  Future<void> removeNote();

  Future<void> updateNote({
    required model.Notes originalNote,
    required String title,
    required String content,
    required int color,
  });
}

class NotesRepository extends INotesRepository {
  final RealmContainer _realmContainer;

  NotesRepository(this._realmContainer);

  @override
  Future<void> addNotes({
    required String title,
    required String content,
    required int color,
  }) async {
    final userId = _realmContainer.app.currentUser?.id;

    throwIf(userId == null, Exception('Unauthorized access'));

    final realm = _realmContainer.getRealmInstance();
    final query = realm.all<model.Notes>();
    final userQuery = realm.query<model.User>('id = "$userId"');

    await _realmContainer.addSubscription(query, name: 'all-notes');
    await _realmContainer.addSubscription(userQuery, name: 'current-user');

    realm.write(
      () => realm.add(
        model.Notes(
          ObjectId(),
          title,
          content,
          color: color,
          holder: userQuery.single,
        ),
      ),
    );
  }

  @override
  Future<void> removeNote() {
    // TODO: implement removeNote
    throw UnimplementedError();
  }

  @override
  Future<List<model.Notes>> searchNotes({required String title}) {
    // TODO: implement searchNotes
    throw UnimplementedError();
  }

  @override
  Future<void> updateNote({
    required model.Notes originalNote,
    required String title,
    required String content,
    required int color,
  }) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }

  @override
  Stream<List<model.Notes>> watchNotes() async* {
    final userId = _realmContainer.app.currentUser?.id;

    throwIf(userId == null, Exception('Unauthorized access'));

    final realm = _realmContainer.getRealmInstance();
    final query = realm.all<model.Notes>();

    await _realmContainer.addSubscription(query, name: 'all-notes');

    yield* query.changes.map((event) => event.results.map((e) => e).toList());
  }
}
