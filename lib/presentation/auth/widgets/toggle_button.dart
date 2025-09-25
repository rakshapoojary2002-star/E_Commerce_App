import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final bool isSignIn;
  final VoidCallback toggleAuthMode;

  const ToggleButton({required this.isSignIn, required this.toggleAuthMode});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isSignIn ? "Don't have an account?" : "Already have an account?",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: toggleAuthMode,
          child: Text(
            isSignIn ? 'Sign up' : 'Sign in',
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
