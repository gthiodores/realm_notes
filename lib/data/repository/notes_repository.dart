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
    int? color,
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
    int? color,
  }) async {
    final userId = _realmContainer.app.currentUser?.id;

    throwIf(userId == null, Exception('Unauthorized access'));

    final realm = _realmContainer.getRealmInstance();
    final query = realm.query<model.Notes>('holder = "$userId"');
    final userQuery = realm.query<model.User>('_id = "$userId"');

    await _realmContainer.addSubscription(query, name: 'all-notes');
    await _realmContainer.addSubscription(userQuery, name: 'current-user');

    final note = model.Notes(
      ObjectId(),
      title,
      content,
      color: color,
      holder: userQuery.single,
    );

    return realm.write(() => realm.add(note));
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
    final query = realm.query<model.Notes>('_holder = "$userId"');

    await _realmContainer.addSubscription(query, name: 'all-notes');

    yield* query.changes.map((event) => event.results.map((e) => e).toList());
  }
}
