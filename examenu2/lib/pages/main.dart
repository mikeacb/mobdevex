import 'package:examenu2/pages/home/home.dart';
import 'package:examenu2/pages/login/login_page.dart';
import 'package:examenu2/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent));
  runApp(MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Color(0xFF2661FA),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity),
    initialRoute: 'login',
    routes: {
      'home': (BuildContext context) => Home(),
      'login': (BuildContext context) => LoginPage(),
      'register': (BuildContext context) => RegisterPage(),
    },
  ));
}
