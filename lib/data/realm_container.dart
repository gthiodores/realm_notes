import 'package:realm/realm.dart';
import 'package:realm_notes/data/model/user.dart' as model;
import 'package:realm_notes/injector.dart';

/// A container for Realm SDK's [Realm] object.
///
/// Wraps the [App] singleton and [Realm] object to perform certain actions.
class RealmContainer {
  final App app;
  Realm? _realm;

  // The singleton object for this container
  static final RealmContainer _instance = RealmContainer._internal(
    injector.get(),
  );

  // Create a factory constructor that returns the singleton instance
  factory RealmContainer() => _instance;

  // An internal constructor
  RealmContainer._internal(this.app);

  /// Get the realm instance in this container.
  ///
  /// Throws an exception when user is not logged in.
  Realm getRealmInstance() {
    if (_realm != null) return _realm!;

    if (app.currentUser == null) throw Exception('User is not logged in');

    _realm = Realm(
      Configuration.flexibleSync(
        app.currentUser!,
        [model.Notes.schema, model.User.schema],
      ),
    );

    return _realm!;
  }

  /// A simple utility tool to add subscriptions
  Future<void> addSubscription(
    RealmResults query, {
    required String name,
  }) async {
    getRealmInstance().subscriptions.update((mutableSubscriptions) {
      if (mutableSubscriptions.any((element) => element.name == name)) {
        return;
      }

      mutableSubscriptions.add(query, name: name);
    });
    await getRealmInstance().subscriptions.waitForSynchronization();
  }

  // Clear realm instance and log out
  Future<void> logout() async {
    // Close and invalidate realm instance
    _realm?.close();
    _realm = null;

    // log out
    await app.currentUser?.logOut();
  }
}
