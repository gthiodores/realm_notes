import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:realm_notes/data/realm_container.dart';
import 'package:realm_notes/data/repository/notes_repository.dart';
import 'package:realm_notes/domain/get_log_in_status_use_case.dart';
import 'package:realm_notes/domain/log_in_with_email_use_case.dart';
import 'package:realm_notes/domain/log_out_use_case.dart';
import 'package:realm_notes/domain/register_user_use_case.dart';
import 'package:realm_notes/domain/validate_email.dart';
import 'package:realm_notes/domain/validate_password.dart';
import 'package:realm_notes/domain/watch_notes_use_case.dart';

final injector = GetIt.instance;

void injectDependencies() {
  // Data source inject
  injector.registerSingleton(
    App(AppConfiguration("relationship-testing-ehnlq")),
  );
  injector.registerSingleton(RealmContainer());

  // Repository inject
  injector.registerSingleton<INotesRepository>(NotesRepository(injector.get()));

  /// Validate credentials use case
  injector.registerFactory(() => ValidateEmail());
  injector.registerFactory(() => ValidatePassword());

  /// Login use case inject
  injector.registerFactory(() => GetLogInStatusUseCase(injector.get()));
  injector.registerFactory(() => LogInWithEmailUseCase(injector.get()));
  injector.registerFactory(() => LogOutUseCase(injector.get()));

  // Register use case inject
  injector.registerFactory(() => RegisterUserUseCase(injector.get()));

  // Note list use case
  injector.registerFactory(() => WatchNotesUseCase(injector.get()));
}
