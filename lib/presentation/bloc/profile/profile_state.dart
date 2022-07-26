part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final bool shouldLogOut;
  final User? userDetail;

  const ProfileState({this.shouldLogOut = false, this.userDetail});

  ProfileState copyWith({bool? shouldLogOut, User? userDetail}) => ProfileState(
        shouldLogOut: shouldLogOut ?? this.shouldLogOut,
        userDetail: userDetail ?? this.userDetail,
      );

  @override
  List<Object> get props => [shouldLogOut];
}
