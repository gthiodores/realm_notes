import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';

final injector = GetIt.instance;

void injectDependencies() {
  injector.registerSingleton(
    App(AppConfiguration("relationship-testing-ehnlq")),
  );
}
