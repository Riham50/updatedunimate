// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart'; // This is the file flutterfire generated
// import 'auth/auth_service.dart';
// import 'screens/home_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'UniMate',
//       debugShowCheckedModeBanner: false,
//       home: AuthScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home_screen.dart'; // Your HomeScreen path
import 'auth/auth_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const UniMateApp());
}

class UniMateApp extends StatelessWidget {
  const UniMateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1F2D3D),
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F2D3D),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF2E3A59)),
          bodyMedium: TextStyle(color: Color(0xFF4E5D72)),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.blueGrey,
        ),
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? AuthScreen() // Replace with your login screen
          : HomeScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => AuthScreen(),
      },
    );
  }
}
