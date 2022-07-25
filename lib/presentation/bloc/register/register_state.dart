part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String username;
  final String password;
  final String confirm;
  final String? message;
  final bool success;
  final bool loading;

  const RegisterState({
    required this.username,
    required this.password,
    required this.confirm,
    this.message,
    this.loading = false,
    this.success = false,
  });

  const RegisterState.initial()
      : username = '',
        password = '',
        confirm = '',
        message = null,
        success = false,
        loading = false;

  RegisterState copyWith({
    String? username,
    String? password,
    String? confirm,
    String? message,
    bool? success,
    bool? loading,
  }) =>
      RegisterState(
        username: username ?? this.username,
        password: password ?? this.password,
        confirm: confirm ?? this.confirm,
        success: success ?? false,
        loading: loading ?? false,
        message: message,
      );

  @override
  List<Object?> get props => [
        username,
        password,
        confirm,
        success,
        loading,
        message,
      ];
}
