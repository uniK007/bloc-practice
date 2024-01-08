// Event class for the authentication actions
import 'package:bloc_practice/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthEvent { signIn, signOut }

// State class for representing the authentication state
class AuthState {
  final User? user;

  AuthState(this.user);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthState(null));

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event == AuthEvent.signIn) {
      final User? user = await authService.signInWithGoogle();
      yield AuthState(user);
    } else if (event == AuthEvent.signOut) {
      await authService.signOut();
      yield AuthState(null);
    }
  }
}
