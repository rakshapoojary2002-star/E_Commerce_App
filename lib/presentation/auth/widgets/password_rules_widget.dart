import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordRule extends StatelessWidget {
  final String text;
  final bool satisfied;

  const PasswordRule({super.key, required this.text, required this.satisfied});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(
          satisfied ? Icons.check_circle : Icons.cancel,
          size: 14.sp,
          color: satisfied ? Colors.green : colorScheme.error,
        ),
        SizedBox(width: 6.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            color: satisfied ? Colors.green : colorScheme.error,
          ),
        ),
      ],
    );
  }
}

class PasswordRulesToggle extends StatelessWidget {
  final bool showRules;
  final VoidCallback toggleRules;

  const PasswordRulesToggle({
    super.key,
    required this.showRules,
    required this.toggleRules,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleRules,
      child: Row(
        children: [
          Text(
            "Password requirements",
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Icon(
            showRules ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            size: 18.sp,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
