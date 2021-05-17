import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:weak_plan/service/auth_service.dart';

class LoginPage extends StatelessWidget {
  final AuthService _authService;

  const LoginPage(this._authService);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weak Plan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _authService.login(Provider.google);
              },
              child: Text('Login With Google'),
            ),
            ElevatedButton(
              onPressed: () {
                _authService.login(Provider.github);
              },
              child: Text('Login With GitHub'),
            ),
          ],
        ),
      ),
    );
  }
}
