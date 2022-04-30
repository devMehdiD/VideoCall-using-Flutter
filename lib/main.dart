import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mettingscall/home/homecall.dart';
import 'package:mettingscall/home/homepage.dart';
import 'package:mettingscall/splashscren/spalshscren.dart';
import 'package:mettingscall/statemangment/statmangment.dart';
import 'package:provider/provider.dart';

bool isLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (FirebaseAuth.instance.currentUser != null) {
    isLogin = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData dark = ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
            elevation: 0,
            color: Colors.transparent,
            foregroundColor: Colors.white));
    ThemeData ligth = ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
            color: Colors.transparent,
            foregroundColor: Colors.black,
            elevation: 0));
    return ChangeNotifierProvider(
        create: (context) => StateManagment(),
        builder: (context, child) {
          final prov = Provider.of<StateManagment>(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: prov.darkMode ? dark : ligth,
              home: isLogin ? const HomePage() : SplasScren());
        });
  }
}
