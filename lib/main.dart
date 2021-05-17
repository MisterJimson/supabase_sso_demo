import 'package:flutter/material.dart';
import 'package:weak_plan/service/auth_service.dart';
import 'package:weak_plan/ui/home_page.dart';
import 'package:weak_plan/ui/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _authService.addListener(() {
      setState(() {
        isLoggedIn = _authService.isLoggedIn;
      });
    });
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weak Plan',
      home: isLoggedIn ? HomePage() : LoginPage(_authService),
    );
  }
}
