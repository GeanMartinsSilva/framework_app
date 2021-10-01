import 'package:flutter/material.dart';
import 'package:framework_app/app/views/login_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xff090B20)),
        primaryColor: Colors.purple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xff7900DF),
          //secondary: Color(0xff090B20),
        ),
      ),
      home: LoginPage(),
    );
  }
}

final ThemeData temaPadrao = ThemeData(
  primaryColor: Colors.purple,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Color(0xff7b1fa2),
  ),
);
