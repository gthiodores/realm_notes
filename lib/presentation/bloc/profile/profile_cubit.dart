import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm/realm.dart';
import 'package:realm_notes/data/realm_container.dart';
import 'package:realm_notes/domain/log_out_use_case.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final LogOutUseCase _logOut;

  ProfileCubit({required LogOutUseCase logOut})
      : _logOut = logOut,
        super(ProfileState(userDetail: RealmContainer().app.currentUser));

  Future<void> onLogOut() async {
    await _logOut.execute();
    emit(state.copyWith(shouldLogOut: true));
  }
}
