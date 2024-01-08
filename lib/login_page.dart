import 'package:bloc_practice/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () async {
                if (state.user == null) {
                  authBloc.add(AuthEvent.signIn);
                }
              },
              child: const Text('Sign in'),
            );
          },
        ),
      ),
    );
  }
}
