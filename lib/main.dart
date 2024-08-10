import 'package:communication/Authentication/sign_in.dart';
import 'package:communication/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Themes/themes.dart';

void main() async {
  //  ensure the binding of flutter widgets
  WidgetsFlutterBinding.ensureInitialized();
  //  initialize the firebase backend with the original project
  await Firebase.initializeApp(
    //  using the default firebase options
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //running the application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightMode,
      // darkTheme: darkMode,
      home: const SignInPage(),
    );
  }
}
