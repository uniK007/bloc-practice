import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthService {
  Future<User?> signInWithGoogle();
  Future<void> signOut();
}

class LogInWithGoogleFailure implements Exception {
  final String message;

  LogInWithGoogleFailure(this.message);
}

class GoogleAuthService extends AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          await _cacheUserData(user); // Save user data in cache
        }
        return user;
      } else {
        throw LogInWithGoogleFailure('Google Sign-In aborted');
      }
    } catch (e) {
      print("Error signing in with Google: $e");
      throw LogInWithGoogleFailure('Google Sign-In failed');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      await _clearUserData(); // Clear user data from cache on sign-out
    } catch (error) {
      print("Error signing out: $error");
    }
  }

  Future<void> _cacheUserData(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', user.uid);
    await prefs.setString('user_email', user.email ?? '');
    // Add more data to cache as needed (e.g., user display name, photoURL)
  }

  Future<void> _clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_id');
    await prefs.remove('user_email');
    // Remove other cached data if needed
  }
}
