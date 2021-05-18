import 'package:flutter/material.dart';
import 'package:weak_plan/service/auth_service.dart';
import 'package:weak_plan/ui/home_page.dart';
import 'package:weak_plan/ui/login_page.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weak Plan',
      home: isLoggedIn ? HomePage() : LoginPage(_authService),
    );
  }

  @override
  void dispose() {
    _authService.dispose();
    super.dispose();
  }
}
