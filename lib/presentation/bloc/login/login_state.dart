part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final String? message;
  final bool loginSuccess;
  final bool loading;

  const LoginState({
    required this.email,
    required this.password,
    required this.loginSuccess,
    this.loading = false,
    this.message,
  });

  const LoginState.initial()
      : email = '',
        password = '',
        loginSuccess = false,
        loading = false,
        message = null;

  LoginState copyWith({
    String? email,
    String? password,
    String? message,
    bool? loginSuccess,
    bool? loading,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        loginSuccess: loginSuccess ?? this.loginSuccess,
        message: message,
        loading: loading ?? false,
      );

  @override
  List<Object?> get props => [email, password, loginSuccess, message, loading];
}
