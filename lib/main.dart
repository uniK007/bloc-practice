import 'package:bloc_practice/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

Future<void> fetchRemoteConfig() async {
  try {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.fetchAndActivate();
  } catch (e) {
    print("Error fetching remote config: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch remote config values
    fetchRemoteConfig();

    // Get background color and title from remote config
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    // Color bgColor =
    //     Color(int.parse(remoteConfig.getString('background_color')));
    String title = remoteConfig.getString('title');

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'Welcome to the Homepage!',
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ),
    );
  }
}
