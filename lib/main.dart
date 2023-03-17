import 'package:flutter/material.dart';

import 'app/modules/notes/notepad_view.dart';
import 'app/services/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GDSC Notepad',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotepadView(),
    );
  }
}
