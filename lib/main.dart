import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myChat/screens/auth_screen.dart';
import 'package:myChat/screens/chat_screen.dart';
import 'package:myChat/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _init = Firebase.initializeApp();

    return FutureBuilder(
      future: _init,
      builder: (ctx, appSnapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Chat',
          theme: ThemeData(
            primarySwatch: Colors.pink,
            backgroundColor: Colors.pink,
            accentColor: Colors.deepPurple,
            accentColorBrightness: Brightness.dark,
            buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.pink,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: appSnapshot.connectionState == ConnectionState.waiting
              ? SplashScreen()
              : StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (ctx, userSnapshot) {
                    if (userSnapshot.hasData) {
                      return ChatScreen();
                    } else {
                      return AuthScreen();
                    }
                  },
                ),
        );
      },
    );
  }
}
