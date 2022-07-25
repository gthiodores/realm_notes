part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterUsernameChanged extends RegisterEvent {
  final String username;

  const RegisterUsernameChanged(this.username);

  @override
  List<Object?> get props => [username];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class RegisterPasswordConfirmChanged extends RegisterEvent {
  final String confirm;

  const RegisterPasswordConfirmChanged(this.confirm);

  @override
  List<Object?> get props => [confirm];
}

class RegisterActionTapped extends RegisterEvent {
  @override
  List<Object?> get props => [];
}
