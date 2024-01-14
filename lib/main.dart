import 'package:firebase_app/firebase_options.dart';
import 'package:firebase_app/authentication/auth_check.dart';
import 'package:firebase_app/theme/dark_theme.dart';
import 'package:firebase_app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheck(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
