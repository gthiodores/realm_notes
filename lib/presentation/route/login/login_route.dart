import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/injector.dart';
import 'package:realm_notes/presentation/bloc/login/login_bloc.dart';
import 'package:realm_notes/presentation/route/login/register_bottom_bar.dart';
import 'package:realm_notes/presentation/route/note/list/note_list_route.dart';
import 'package:realm_notes/presentation/route/register/register_route.dart';
import 'package:realm_notes/presentation/widget/credentials_input_wireframe.dart';

class LoginRoute extends StatelessWidget {
  static const String route = '/login';

  const LoginRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        injector.get(),
        injector.get(),
        injector.get(),
        injector.get(),
      )..add(LoginInit()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.loginSuccess) {
            Navigator.pushReplacementNamed(context, NoteListRoute.route);
          }

          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white,
          body: state.loading
              ? const Center(child: CircularProgressIndicator())
              : CredentialsInputWireframe(
                  title: Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                  fieldPassword: TextFormField(
                    onChanged: (password) => context
                        .read<LoginBloc>()
                        .add(LoginPasswordInput(password)),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.key),
                      border: UnderlineInputBorder(),
                      label: Text('Password'),
                      // hintText: 'Password',
                    ),
                    obscuringCharacter: '*',
                    obscureText: true,
                  ),
                  fieldUsername: TextFormField(
                    onChanged: (email) => context
                        .read<LoginBloc>()
                        .add(LoginUsernameInput(email)),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: UnderlineInputBorder(),
                      label: Text('Username / E-mail'),
                      // hintText: 'Username / E-mail',
                    ),
                  ),
                  actionButton: ElevatedButton(
                    onPressed: () =>
                        context.read<LoginBloc>().add(LoginClicked()),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 42),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                  forgotPassword: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                ),
          bottomNavigationBar: state.loading
              ? Container()
              : RegisterBottomBar(
                  onRegisterTap: () async {
                    await Navigator.pushNamed(context, RegisterRoute.route)
                        .then((result) {
                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Successfully registered')),
                        );
                      }
                    });
                  },
                ),
        ),
      ),
    );
  }
}
