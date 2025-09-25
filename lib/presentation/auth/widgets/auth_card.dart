import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_form.dart';

class AuthCard extends StatelessWidget {
  final bool isSignIn;
  final VoidCallback? onSignUpSuccess;

  const AuthCard({super.key, required this.isSignIn, this.onSignUpSuccess});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      key: ValueKey(isSignIn),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: AuthForm(isSignIn: isSignIn, onSignUpSuccess: onSignUpSuccess),
    );
  }
}
