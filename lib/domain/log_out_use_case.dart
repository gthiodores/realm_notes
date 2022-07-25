import 'package:realm_notes/data/realm_container.dart';

class LogOutUseCase {
  final RealmContainer _realmContainer;

  const LogOutUseCase(this._realmContainer);

  Future<void> execute() => _realmContainer.logout();
}
