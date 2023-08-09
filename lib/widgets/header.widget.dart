import 'package:flutter/material.dart';
import 'package:flutter_navigation/widgets/loggedin_signup.widget.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text('Flutter go_router demo'),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: LoggedInSignupButton(),
        ),
      ],
    );
  }
}
