import 'package:communication/Authentication/sign_in.dart';
import 'package:communication/Provider/theme_provider.dart';
import 'package:communication/Themes/themes.dart';
import 'package:communication/Utilities/Services/Chat%20Services/chat_services.dart';
import 'package:communication/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ChatServices()),
      ],
      builder: (context, index) {
        return MaterialApp(
          theme: lightMode,
          darkTheme: darkMode,
          home: const SignInPage(),
        );
      },
    );
  }
}
