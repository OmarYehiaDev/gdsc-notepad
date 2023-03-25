import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_notepad/app/modules/login/login_screen.dart';
import 'package:gdsc_notepad/app/services/auth_methods.dart';

import 'app/modules/notes/notepad_view.dart';
import 'app/services/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.initPrefs();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notaty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: AuthMethods().user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasData) {
            return const NotepadView();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
