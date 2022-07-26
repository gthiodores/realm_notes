import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/injector.dart';
import 'package:realm_notes/presentation/bloc/profile/profile_cubit.dart';
import 'package:realm_notes/presentation/route/login/login_route.dart';

class ProfileRoute extends StatelessWidget {
  static const String route = '/profile';

  const ProfileRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(logOut: injector.get()),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.shouldLogOut) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginRoute.route,
              (route) => false,
            );
          }
        },
        builder: (context, state) => Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                    onPressed: () => print('edit profile'),
                    iconSize: 24,
                    splashRadius: 24,
                    tooltip: 'Edit Profile',
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () async =>
                        await context.read<ProfileCubit>().onLogOut(),
                    iconSize: 24,
                    splashRadius: 24,
                    tooltip: 'Log Out',
                    icon: const Icon(Icons.logout),
                  ),
                ],
                floating: true,
                snap: true,
              ),
              SliverToBoxAdapter(
                child: Text(state.userDetail?.profile.email ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
