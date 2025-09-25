import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'text_field_widget.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final TextInputType? keyboardType;
  final IconData icon;
  final bool visible; // NEW

  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.currentFocus,
    this.nextFocus,
    this.keyboardType,
    this.icon = Icons.person_outline,
    this.visible = true, // default true
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: TextFieldWidget(
        controller: controller,
        label: label,
        hint: hint,
        icon: icon,
        focusNode: currentFocus,
        textInputAction:
            nextFocus != null ? TextInputAction.next : TextInputAction.done,
        onSubmitted:
            (_) =>
                nextFocus != null
                    ? FocusScope.of(context).requestFocus(nextFocus)
                    : null,
        keyboardType: keyboardType,
      ),
    );
  }
}
