part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginInit extends LoginEvent {
  @override
  List<Object?> get props => [];
}

class LoginPasswordInput extends LoginEvent {
  final String password;

  const LoginPasswordInput(this.password);

  @override
  List<Object?> get props => [password];
}

class LoginUsernameInput extends LoginEvent {
  final String username;

  const LoginUsernameInput(this.username);

  @override
  List<Object?> get props => [username];
}

class LoginClicked extends LoginEvent {
  @override
  List<Object?> get props => [];
}
