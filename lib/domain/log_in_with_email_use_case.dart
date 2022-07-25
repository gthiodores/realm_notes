import 'package:realm/realm.dart';
import 'package:realm_notes/data/realm_container.dart';

class LogInWithEmailUseCase {
  final RealmContainer _realmContainer;

  const LogInWithEmailUseCase(this._realmContainer);

  Future<User> execute({required String email, required String password}) =>
      _realmContainer.app.logIn(Credentials.emailPassword(email, password));
}
