import 'dart:io';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/utils/flutter_secure.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
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

  // 🔴 Field error map
  Map<String, String?> _fieldErrors = {
    'firstName': null,
    'lastName': null,
    'email': null,
    'phone': null,
    'password': null,
  };

  bool get _hasMinLength => _passwordController.text.length >= 8;
  bool get _hasUppercase => _passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get _hasLowercase => _passwordController.text.contains(RegExp(r'[a-z]'));
  bool get _hasNumber => _passwordController.text.contains(RegExp(r'[0-9]'));
  bool get _hasSpecial =>
      _passwordController.text.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      if (mounted) setState(() {});
    });
  }

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

  void _clearErrors() {
    _fieldErrors.updateAll((key, value) => null);
  }

  Future<void> _submit() async {
    _clearErrors();

    if (!widget.isSignIn) {
      final firstNameError = Validators.validateFirstName(
        _firstNameController.text,
      );
      if (firstNameError != null) {
        _fieldErrors['firstName'] = firstNameError;
        _firstNameFocus.requestFocus();
        _showMessage(firstNameError, success: false);
        setState(() {});
        return;
      }

      final lastNameError = Validators.validateLastName(
        _lastNameController.text,
      );
      if (lastNameError != null) {
        _fieldErrors['lastName'] = lastNameError;
        _lastNameFocus.requestFocus();
        _showMessage(lastNameError, success: false);
        setState(() {});
        return;
      }

      final emailError = Validators.validateEmail(_emailController.text);
      if (emailError != null) {
        _fieldErrors['email'] = emailError;
        _emailFocus.requestFocus();
        _showMessage(emailError, success: false);
        setState(() {});
        return;
      }

      final phoneError = Validators.validatePhone(_phoneController.text);
      if (phoneError != null) {
        _fieldErrors['phone'] = phoneError;
        _phoneFocus.requestFocus();
        _showMessage(phoneError, success: false);
        setState(() {});
        return;
      }

      final passwordError = Validators.validatePassword(
        _passwordController.text,
      );
      if (passwordError != null) {
        _fieldErrors['password'] = passwordError;
        _passwordFocus.requestFocus();
        _showMessage(passwordError, success: false);
        setState(() {});
        return;
      }
    } else {
      final emailError = Validators.validateEmail(_emailController.text);
      if (emailError != null) {
        _fieldErrors['email'] = emailError;
        _emailFocus.requestFocus();
        _showMessage(emailError, success: false);
        setState(() {});
        return;
      }

      final passwordError = Validators.validateLoginPassword(
        _passwordController.text,
      );
      if (passwordError != null) {
        _fieldErrors['password'] = passwordError;
        _passwordFocus.requestFocus();
        _showMessage(passwordError, success: false);
        setState(() {});
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      if (widget.isSignIn) {
        final user = await ref.read(
          loginProvider({
            'email': _emailController.text.trim(),
            'password': _passwordController.text,
          }).future,
        );

        if (user.token == null) throw Exception('Login failed');

        await SecureStorage.saveToken(user.token!);

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
            'email': _emailController.text.trim(),
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
    } on ServerException catch (e) {
      if (e.statusCode == 409) { // Email already exists
        _fieldErrors['email'] = e.message;
        _emailFocus.requestFocus();
        _showMessage(e.message, success: false);
      } else if (e.statusCode == 401) { // Invalid credentials
        _showMessage(e.message, success: false);
      } else if (e.statusCode == 400) { // Validation error from backend
        _showMessage(e.message, success: false);
      } else {
        _showMessage('An unexpected error occurred. Please try again.', success: false);
      }
    } on SocketException {
      _showMessage('No internet connection. Please check your network.', success: false);
    } catch (e, stackTrace) {
      debugPrint('Auth error: $e\n$stackTrace');
      _showMessage('An unexpected error occurred. Please try again.', success: false);
    } finally {
      if(mounted) {
        setState(() => _isLoading = false);
      }
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
            errorText: _fieldErrors['firstName'],
          ),

          // Last Name
          AuthTextField(
            controller: _lastNameController,
            label: 'Last Name (optional)',
            hint: 'Enter Last Name',
            currentFocus: _lastNameFocus,
            nextFocus: _emailFocus,
            visible: !widget.isSignIn,
            errorText: _fieldErrors['lastName'],
          ),

          // Email
          AuthTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Enter Email',
            currentFocus: _emailFocus,
            nextFocus: widget.isSignIn ? _passwordFocus : _phoneFocus,
            keyboardType: TextInputType.emailAddress,
            errorText: _fieldErrors['email'],
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
            errorText: _fieldErrors['phone'],
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
            errorText: _fieldErrors['password'],
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
              disabledBackgroundColor: colorScheme.tertiary.withOpacity(0.5),
              disabledForegroundColor: colorScheme.onTertiary,
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
}
