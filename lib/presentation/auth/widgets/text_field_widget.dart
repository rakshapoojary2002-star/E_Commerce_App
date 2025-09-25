import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  final String? errorText; // ✅ NEW

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
    this.errorText, // ✅ NEW
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 14.sp),
            prefixIcon: Icon(
              icon,
              size: 20.sp,
              color: colorScheme.onSurfaceVariant,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: colorScheme.surfaceContainerLow,
            errorText: errorText, // ✅ show error message
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            errorBorder: OutlineInputBorder(
              // ✅ red border when error
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              // ✅ red border on focus + error
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}
