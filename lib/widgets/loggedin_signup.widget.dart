import 'package:flutter/material.dart';
import 'package:flutter_navigation/config/routes/routes.dart';
import 'package:flutter_navigation/data/app_data.dart';
import 'package:flutter_navigation/events/app_events.dart';
import 'package:go_router/go_router.dart';

class LoggedInSignupButton extends StatefulWidget {
  const LoggedInSignupButton({super.key});

  @override
  State<LoggedInSignupButton> createState() => _LoggedInSignupButtonState();
}

class _LoggedInSignupButtonState extends State<LoggedInSignupButton> {
  _LoggedInSignupButtonState() {
    AppEvents.onLoginEvent((event) => _onLoginEvent(event));
    AppEvents.onLogoutEvent((event) => _onLogoutEvent(event));
  }

  final Icon _defaultIcon = const Icon(Icons.account_circle_outlined);
  Icon _icon = const Icon(Icons.account_circle_outlined);
  final Widget _defaultTitle = const Text('Login/SignUp');
  Widget _title = const Text('Login/SignUp');
  final bool _isLoggedIn = AppData.userLoggedIn != null;

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedIn) {
      return _loginSignupButton(context);
    } else {
      return _logoutDropdownButton(context);
    }
  }

  Widget _loginSignupButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: _icon,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      onPressed: () => context.push(AppRouter.loginRoute()),
      label: _title,
    );
  }

  Widget _logoutDropdownButton(BuildContext context) {
    return DropdownButton(items: const [
      DropdownMenuItem(
        value: 'logout',
        child: Text('Logout'),
      )
    ], onChanged: _onLogout);
  }

  void _onLogout(String? value) {}

  void _onLoginEvent(LoginEvent event) {
    setState(() {
      _icon = const Icon(Icons.account_circle_rounded);
      _title = Text(event.user.email);
    });
  }

  void _onLogoutEvent(LogoutEvent event) {
    setState(() {
      _icon = _defaultIcon;
      _title = _defaultTitle;
    });
  }
}
