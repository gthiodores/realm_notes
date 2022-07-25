import 'package:realm_notes/data/realm_container.dart';

class GetLogInStatusUseCase {
  final RealmContainer _realmContainer;

  const GetLogInStatusUseCase(this._realmContainer);

  bool execute() => _realmContainer.app.currentUser != null;
}
