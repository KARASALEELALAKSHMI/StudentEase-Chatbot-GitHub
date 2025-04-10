import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'admin_updates_screen.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'signin_screen.dart';
import 'updates_screen.dart';
import 'chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Ease',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/signin': (context) => SigninScreen(),
        '/updates': (context) => UpdatesScreen(),
        '/chat': (context) => ChatScreen(),
        '/admin': (context) => AdminUpdatesScreen(),
      },
    );
  }
}
