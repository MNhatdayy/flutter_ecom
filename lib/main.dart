import 'package:flutter/material.dart';
import 'package:flutter_ecom/pages/auth/LoginScreen.dart';
import 'package:flutter_ecom/pages/HomeScreen.dart';
import 'package:flutter_ecom/pages/auth/RegisterScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_ecom/core/services/AuthService.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  bool logedIn = await AuthService().isTokenValid();
    runApp(MyApp(logedIn: logedIn));
}

class MyApp extends StatelessWidget {
  final bool logedIn;
  MyApp({required this.logedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: logedIn ? HomeScreen() : LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
