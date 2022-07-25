import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/domain/get_log_in_status_use_case.dart';
import 'package:realm_notes/domain/log_in_with_email_use_case.dart';
import 'package:realm_notes/domain/validate_email.dart';
import 'package:realm_notes/domain/validate_password.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GetLogInStatusUseCase _getLogInStatusUseCase;
  final LogInWithEmailUseCase _logInWithEmailUseCase;
  final ValidateEmail _validateEmail;
  final ValidatePassword _validatePassword;

  LoginBloc(
    this._getLogInStatusUseCase,
    this._logInWithEmailUseCase,
    this._validateEmail,
    this._validatePassword,
  ) : super(const LoginState.initial()) {
    on<LoginUsernameInput>(
      (event, emit) => emit(state.copyWith(email: event.username)),
    );

    on<LoginPasswordInput>(
      (event, emit) => emit(state.copyWith(password: event.password)),
    );

    on<LoginInit>((event, emit) {
      emit(state.copyWith(loading: true));
      emit(
        state.copyWith(
          loginSuccess: _getLogInStatusUseCase.execute(),
          loading: false,
        ),
      );
    });

    on<LoginClicked>(
      (event, emit) async {
        emit(state.copyWith(loading: true));

        final isEmailValid = _validateEmail.execute(state.email);
        final isPasswordValid = _validatePassword.execute(state.password);

        if (!isEmailValid) {
          emit(state.copyWith(message: 'Email bukan format email yang betul'));
          return;
        }

        if (!isPasswordValid) {
          emit(state.copyWith(message: 'Password tidak sesuai dengan format'));
          return;
        }

        await _logInWithEmailUseCase.execute(
          email: state.email,
          password: state.password,
        );

        if (!_getLogInStatusUseCase.execute()) {
          emit(state.copyWith(message: 'User tersebut belum terdaftar'));
          return;
        }
        emit(state.copyWith(loginSuccess: true));
      },
      transformer: droppable(),
    );
  }
}
