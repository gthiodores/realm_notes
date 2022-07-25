import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/domain/register_user_use_case.dart';
import 'package:realm_notes/domain/validate_email.dart';
import 'package:realm_notes/domain/validate_password.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ValidateEmail _validateEmail;
  final ValidatePassword _validatePassword;
  final RegisterUserUseCase _registerUser;

  RegisterBloc(
    this._validateEmail,
    this._validatePassword,
    this._registerUser,
  ) : super(const RegisterState.initial()) {
    on<RegisterUsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });

    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<RegisterPasswordConfirmChanged>((event, emit) {
      emit(state.copyWith(confirm: event.confirm));
    });

    on<RegisterActionTapped>((event, emit) async {
      emit(state.copyWith(loading: true));

      if (state.password != state.confirm) {
        emit(
          state.copyWith(
            message: 'Confirm password is different from password',
          ),
        );
        return;
      }

      if (!_validatePassword.execute(state.password)) {
        emit(
          state.copyWith(
            message:
                'Password must be at least 6 characters long and not start with a number',
          ),
        );
        return;
      }

      if (!_validateEmail.execute(state.username)) {
        emit(state.copyWith(message: 'Not a valid email'));
        return;
      }

      final result = await _registerUser.execute(
        username: state.username,
        password: state.password,
      );

      result.fold(
        (failure) => emit(state.copyWith(message: failure.message)),
        (success) => emit(state.copyWith(success: true)),
      );
    });
  }
}
