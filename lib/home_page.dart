import 'package:bloc_practice/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${state.user!.email}'),
                ElevatedButton(
                  onPressed: () {
                    authBloc.add(AuthEvent.signOut);
                  },
                  child: const Text('SIGN OUT'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
