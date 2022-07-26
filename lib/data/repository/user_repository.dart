import 'package:realm/realm.dart';
import 'package:realm_notes/data/realm_container.dart';

abstract class IUserRepository {
  Future<void> updateUsername({required String username});

  Future<void> updateProfileImage({required String imageUrl});

  Future<User> getCurrentUser();
}

class UserRepository extends IUserRepository {
  final RealmContainer _realmContainer;

  UserRepository(this._realmContainer);

  @override
  Future<void> updateProfileImage({required String imageUrl}) {
    // TODO: implement updateProfileImage
    throw UnimplementedError();
  }

  @override
  Future<void> updateUsername({required String username}) {
    // TODO: implement updateUsername
    throw UnimplementedError();
  }

  @override
  Future<User> getCurrentUser() async {
    final userId = _realmContainer.app.currentUser?.id;

    if (userId == null) throw Exception('Unauthorized Access');

    return _realmContainer.app.currentUser!;
  }
}
