import 'package:flutter/material.dart';

import '../../services/auth_methods.dart';
import '../notes/notepad_view.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              'Notaty',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 80.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            onPressed: () async {
              bool res = await AuthMethods().signInWithGogle(context);
              if (res) {
                Navigator.pushReplacement(
                  _key.currentContext ?? context,
                  MaterialPageRoute(
                    builder: (context) => const NotepadView(),
                  ),
                );
              }
            },
            child: const Text('Login with Google'),
          ),
        ],
      ),
    );
  }
}
