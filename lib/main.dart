import 'package:flutter/material.dart';
import 'package:siklero_admin/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/manage_users_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: LogInScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LogInScreen(),
        '/ManageUsers': (context) => ManageUsers(),
      },
    );
  }
}
