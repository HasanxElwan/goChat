import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:go_chat/screens/chatScreen.dart';
import 'package:go_chat/screens/signInScreen.dart';
import 'package:go_chat/screens/signUpScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          SignUpScreen.id: (context) => SignUpScreen(),
          SignInScreen.id: (context) => SignInScreen(),
          ChatScreen.id: (context) => ChatScreen(),
        },
        initialRoute: SignInScreen.id);
  }
}
