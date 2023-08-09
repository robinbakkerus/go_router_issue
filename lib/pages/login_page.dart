import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_navigation/blog/models/user.dart';
import 'package:flutter_navigation/blog/repostitories/all_users.repo.dart';
import 'package:flutter_navigation/data/app_data.dart';
import 'package:flutter_navigation/events/app_events.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Duration get loginTime => const Duration(milliseconds: 750);

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    try {
      User user = await AllUsersRepo().loginUser(data.name, data.password);
      AppData.userLoggedIn = user;
      AppEvents.fireLoginEvent(user);
      return null;
    } catch (e) {
      return Future.value(e.toString());
    }
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      return 'User not exists';
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 500,
          width: 500,
          child: FlutterLogin(
            // title: 'ECORP',
            logo: const AssetImage('assets/demo_logo.jpg'),
            onLogin: _authUser,
            onSignup: _signupUser,
            onSubmitAnimationCompleted: () {
              context.pop();
            },
            onRecoverPassword: _recoverPassword,
          ),
        ),
      ],
    );
  }
}
