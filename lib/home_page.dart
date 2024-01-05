import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user, required this.auth});

  final User user;
  final FirebaseAuth auth;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.user.email}'),
            ElevatedButton(
              onPressed: () async {
                await widget.auth.signOut();
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text('SIGN OUT'),
            ),
          ],
        ),
      ),
    );
  }
}
