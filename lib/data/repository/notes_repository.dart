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
    final query = realm.all<model.Notes>();
    final userQuery = realm.all<model.User>();

    await _realmContainer.addSubscription(query, name: 'notes');
    await _realmContainer.addSubscription(userQuery, name: 'user');

    final note = model.Notes(
      ObjectId(),
      title,
      content,
      userId!,
      color: color,
    );

    return realm.write(() => realm.add(note));
  }

  @override
  Future<void> removeNote() {
    // TODO: implement removeNote
    throw UnimplementedError();
  }

  @override
  Future<List<model.Notes>> searchNotes({required String title}) async {
    final userId = _realmContainer.app.currentUser?.id;

    throwIf(userId == null, Exception('Unauthorized access'));

    final realm = _realmContainer.getRealmInstance();
    final query = realm.query<model.Notes>('title CONTAINS[c] "$title"');
    final userQuery = realm.all<model.User>();

    await _realmContainer.addSubscription(
      query,
      name: 'search-notes',
      update: true,
    );
    await _realmContainer.addSubscription(userQuery, name: 'user');

    return query.toList();
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

    final userQuery = realm.all<model.User>();
    final query = realm.all<model.Notes>();

    await _realmContainer.addSubscription(userQuery, name: 'user');
    await _realmContainer.addSubscription(query, name: 'notes');

    yield* query.changes.map((event) => event.results.toList());
  }
}
