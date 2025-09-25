import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToggleButton extends StatelessWidget {
  final bool isSignIn;
  final VoidCallback toggleAuthMode;

  const ToggleButton({
    super.key,
    required this.isSignIn,
    required this.toggleAuthMode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isSignIn ? "Don't have an account?" : "Already have an account?",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(width: 4.w), // small spacing
        TextButton(
          onPressed: toggleAuthMode,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ).copyWith(
            overlayColor: MaterialStateProperty.all(
              Colors.transparent,
            ), // remove pressed effect
          ),
          child: Text(
            isSignIn ? 'Sign up' : 'Sign in',
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
