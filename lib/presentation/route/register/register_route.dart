import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_notes/injector.dart';
import 'package:realm_notes/presentation/bloc/register/register_bloc.dart';
import 'package:realm_notes/presentation/widget/credentials_input_wireframe.dart';

class RegisterRoute extends StatelessWidget {
  static const String route = '/register';

  const RegisterRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocProvider(
        create: (_) => RegisterBloc(
          injector.get(),
          injector.get(),
          injector.get(),
        ),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message!)),
              );
            }

            if (state.success) Navigator.pop(context, true);
          },
          builder: (context, state) {
            if (state.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return CredentialsInputWireframe(
              title: Text(
                'Register',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.black),
                textAlign: TextAlign.start,
              ),
              fieldPassword: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (password) => context
                          .read<RegisterBloc>()
                          .add(RegisterPasswordChanged(password)),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        border: UnderlineInputBorder(),
                        label: Text('Password'),
                        // hintText: 'Password',
                      ),
                      obscuringCharacter: '*',
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      onChanged: (password) => context
                          .read<RegisterBloc>()
                          .add(RegisterPasswordConfirmChanged(password)),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.key),
                        border: UnderlineInputBorder(),
                        label: Text('Confirm Password'),
                        // hintText: 'Password',
                      ),
                      obscuringCharacter: '*',
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              fieldUsername: TextFormField(
                onChanged: (email) => context
                    .read<RegisterBloc>()
                    .add(RegisterUsernameChanged(email)),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: UnderlineInputBorder(),
                  label: Text('Username / E-mail'),
                  // hintText: 'Username / E-mail',
                ),
              ),
              actionButton: ElevatedButton(
                onPressed: () =>
                    context.read<RegisterBloc>().add(RegisterActionTapped()),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 42),
                ),
                child: const Text('Register'),
              ),
              forgotPassword: Container(),
            );
          },
        ),
      ),
    );
  }
}
