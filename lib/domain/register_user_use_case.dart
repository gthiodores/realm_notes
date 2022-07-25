import 'package:dartz/dartz.dart';
import 'package:realm_notes/data/realm_container.dart';
import 'package:realm_notes/domain/util/failure.dart';

class RegisterUserUseCase {
  final RealmContainer _realmContainer;

  const RegisterUserUseCase(this._realmContainer);

  Future<Either<Failure, String>> execute({
    required String username,
    required String password,
  }) async {
    try {
      await _realmContainer.app.emailPasswordAuthProvider
          .registerUser(username, password);
      return const Right('Successfully registered');
    } catch (e) {
      return const Left(Failure('Failed to register'));
    }
  }
}
