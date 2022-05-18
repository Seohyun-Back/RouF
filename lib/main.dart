import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:RouF/screens/login_screen.dart';
import 'screens/main_screen.dart';

const MaterialColor primaryGreen = MaterialColor(
  _greenPrimaryValue,
  <int, Color>{
    50: Color(0xFF47992A),
    100: Color(0xFF47992A),
    200: Color(0xFF47992A),
    300: Color(0xFF47992A),
    400: Color(0xFF47992A),
    500: Color(_greenPrimaryValue),
    600: Color(0xFF47992A),
    700: Color(0xFF47992A),
    800: Color(0xFF47992A),
    900: Color(0xFF47992A),
  },
);
const int _greenPrimaryValue = 0xFF47992A;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: primaryGreen,
        fontFamily: 'Mono',
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainScreen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}
