import 'package:e_commerce_app/presentation/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_text_field.dart';
import 'text_field_widget.dart';
import 'remember_me_checkbox.dart';
import 'password_rules_widget.dart';
import '../../home/screens/home_screen.dart';

class AuthForm extends ConsumerStatefulWidget {
  final bool isSignIn;
  final VoidCallback? onSignUpSuccess;

  const AuthForm({super.key, required this.isSignIn, this.onSignUpSuccess});

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _showPasswordRules = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  bool get _hasMinLength => _passwordController.text.length >= 8;
  bool get _hasUppercase => _passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get _hasLowercase => _passwordController.text.contains(RegExp(r'[a-z]'));
  bool get _hasNumber => _passwordController.text.contains(RegExp(r'[0-9]'));
  bool get _hasSpecial =>
      _passwordController.text.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));
  bool get _isPasswordValid =>
      _hasMinLength &&
      _hasUppercase &&
      _hasLowercase &&
      _hasNumber &&
      _hasSpecial;

  void _showMessage(String message, {bool success = true}) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = success ? colorScheme.tertiary : colorScheme.error;
    final textColor = success ? colorScheme.onTertiary : colorScheme.onError;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor, fontSize: 14.sp),
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(12.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _submit() async {
    if (!widget.isSignIn && _firstNameController.text.trim().isEmpty) {
      _showMessage('Please enter first name', success: false);
      return;
    }

    if (_emailController.text.isEmpty ||
        !RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        ).hasMatch(_emailController.text)) {
      _showMessage('Please enter a valid email', success: false);
      return;
    }

    if (!widget.isSignIn && !_isPasswordValid) {
      _showMessage('Password does not meet requirements', success: false);
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (widget.isSignIn) {
        final user = await ref.read(
          loginProvider({
            'email': _emailController.text,
            'password': _passwordController.text,
          }).future,
        );

        if (user.token == null) throw Exception('Login failed');

        _showMessage('Welcome back, ${user.firstName}!');

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen(token: user.token!)),
          );
        }
      } else {
        final user = await ref.read(
          registerProvider({
            'firstName': _firstNameController.text.trim(),
            'lastName': _lastNameController.text.trim(),
            'email': _emailController.text,
            'password': _passwordController.text,
            if (_phoneController.text.trim().isNotEmpty)
              'phone': _phoneController.text.trim(),
          }).future,
        );

        _showMessage('Registered successfully, ${user.firstName}!');
        _firstNameController.clear();
        _lastNameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _phoneController.clear();
        widget.onSignUpSuccess?.call();
      }
    } catch (e, stackTrace) {
      debugPrint('Auth error: $e\n$stackTrace');
      _showMessage('Error: ${e.toString()}', success: false);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.isSignIn ? 'Welcome Back' : 'Get Started',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),

          // First Name
          AuthTextField(
            controller: _firstNameController,
            label: 'First Name',
            hint: 'Enter First Name',
            currentFocus: _firstNameFocus,
            nextFocus: _lastNameFocus,
            visible: !widget.isSignIn,
          ),

          // Last Name
          AuthTextField(
            controller: _lastNameController,
            label: 'Last Name (optional)',
            hint: 'Enter Last Name',
            currentFocus: _lastNameFocus,
            nextFocus: _emailFocus,
            visible: !widget.isSignIn,
          ),

          // Email
          AuthTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Enter Email',
            currentFocus: _emailFocus,
            nextFocus: widget.isSignIn ? _passwordFocus : _phoneFocus,
            keyboardType: TextInputType.emailAddress,
          ),

          // Phone
          AuthTextField(
            controller: _phoneController,
            label: 'Phone (optional)',
            hint: 'Enter Phone Number',
            currentFocus: _phoneFocus,
            nextFocus: _passwordFocus,
            keyboardType: TextInputType.phone,
            visible: !widget.isSignIn,
          ),

          // Password
          TextFieldWidget(
            controller: _passwordController,
            label: 'Password',
            hint: 'Enter Password',
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            focusNode: _passwordFocus,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                size: 18.sp,
                color: colorScheme.onSurfaceVariant,
              ),
              onPressed:
                  () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),

          if (!widget.isSignIn)
            PasswordRulesToggle(
              showRules: _showPasswordRules,
              toggleRules:
                  () =>
                      setState(() => _showPasswordRules = !_showPasswordRules),
            ),

          if (!widget.isSignIn && _showPasswordRules) ...[
            PasswordRule(
              text: "At least 8 characters",
              satisfied: _hasMinLength,
            ),
            PasswordRule(
              text: "One uppercase letter",
              satisfied: _hasUppercase,
            ),
            PasswordRule(
              text: "One lowercase letter",
              satisfied: _hasLowercase,
            ),
            PasswordRule(text: "One number", satisfied: _hasNumber),
            PasswordRule(text: "One special character", satisfied: _hasSpecial),
          ],

          if (widget.isSignIn)
            RememberMeCheckbox(
              value: _rememberMe,
              onChanged: (val) => setState(() => _rememberMe = val!),
            ),

          SizedBox(height: 20.h),

          ElevatedButton(
            onPressed: _isLoading ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.tertiary,
              foregroundColor: colorScheme.onTertiary,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child:
                _isLoading
                    ? SizedBox(
                      height: 20.w,
                      width: 20.w,
                      child: CircularProgressIndicator(
                        color: colorScheme.onTertiary,
                        strokeWidth: 2.w,
                      ),
                    )
                    : Text(
                      widget.isSignIn ? 'Sign In' : 'Sign Up',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}
