import 'package:e_commerce_app/presentation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'text_field_widget.dart';
import '../providers/auth_provider.dart';

class AuthCard extends ConsumerStatefulWidget {
  final bool isSignIn;
  final VoidCallback? onSignUpSuccess; // <-- Callback for switching to SignIn

  const AuthCard({super.key, required this.isSignIn, this.onSignUpSuccess});

  @override
  ConsumerState<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends ConsumerState<AuthCard> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
    super.dispose();
  }

  void _showCustomMessage(String message, {bool success = true}) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = success ? colorScheme.tertiary : colorScheme.error;
    final textColor = success ? colorScheme.onTertiary : colorScheme.onError;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Password validators
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

  Future<void> _submit() async {
    if (!widget.isSignIn && _firstNameController.text.trim().isEmpty) {
      _showCustomMessage('Please enter first name', success: false);
      return;
    }

    if (_emailController.text.isEmpty ||
        !RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        ).hasMatch(_emailController.text)) {
      _showCustomMessage('Please enter a valid email', success: false);
      return;
    }

    if (!widget.isSignIn && !_isPasswordValid) {
      _showCustomMessage('Password does not meet requirements', success: false);
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (widget.isSignIn) {
        // Login
        final user = await ref.read(
          loginProvider({
            'email': _emailController.text,
            'password': _passwordController.text,
          }).future,
        );

        if (user.token == null) {
          throw Exception('Login failed: token not found');
        }

        _showCustomMessage('Welcome back, ${user.firstName}!');

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen(token: user.token!)),
          );
        }
      } else {
        // Register
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

        _showCustomMessage('Registered successfully, ${user.firstName}!');

        // Clear fields
        _firstNameController.clear();
        _lastNameController.clear();
        _emailController.clear();
        _passwordController.clear();
        _phoneController.clear();

        // Switch to SignIn via callback
        widget.onSignUpSuccess?.call();
      }
    } catch (e, stackTrace) {
      debugPrint('Auth error: $e');
      debugPrint('$stackTrace');
      _showCustomMessage('Error: ${e.toString()}', success: false);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildPasswordRule(String text, bool satisfied) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(
          satisfied ? Icons.check_circle : Icons.cancel,
          size: 14,
          color: satisfied ? Colors.green : colorScheme.error,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: satisfied ? Colors.green : colorScheme.error,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.isSignIn ? 'Welcome Back' : 'Get Started',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              if (!widget.isSignIn)
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 300) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              controller: _firstNameController,
                              label: 'First Name',
                              hint: 'Enter First Name',
                              icon: Icons.person_outline,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFieldWidget(
                              controller: _lastNameController,
                              label: 'Last Name (optional)',
                              hint: 'Enter Last Name',
                              icon: Icons.person_outline,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          TextFieldWidget(
                            controller: _firstNameController,
                            label: 'First Name',
                            hint: 'Enter First Name',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(height: 16),
                          TextFieldWidget(
                            controller: _lastNameController,
                            label: 'Last Name (optional)',
                            hint: 'Enter Last Name',
                            icon: Icons.person_outline,
                          ),
                        ],
                      );
                    }
                  },
                ),

              const SizedBox(height: 20),

              TextFieldWidget(
                controller: _emailController,
                label: 'Email',
                hint: 'Enter Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              if (!widget.isSignIn) ...[
                TextFieldWidget(
                  controller: _phoneController,
                  label: 'Phone (optional)',
                  hint: 'Enter Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
              ],

              TextFieldWidget(
                controller: _passwordController,
                label: 'Password',
                hint: 'Enter Password',
                icon: Icons.lock_outline,
                obscureText: _obscurePassword,
                onChanged: (_) => setState(() {}),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),

              if (!widget.isSignIn)
                GestureDetector(
                  onTap:
                      () => setState(
                        () => _showPasswordRules = !_showPasswordRules,
                      ),
                  child: Row(
                    children: [
                      Text(
                        "Password requirements",
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      Icon(
                        _showPasswordRules
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),

              if (!widget.isSignIn && _showPasswordRules) ...[
                const SizedBox(height: 8),
                _buildPasswordRule("At least 8 characters", _hasMinLength),
                _buildPasswordRule("One uppercase letter", _hasUppercase),
                _buildPasswordRule("One lowercase letter", _hasLowercase),
                _buildPasswordRule("One number", _hasNumber),
                _buildPasswordRule("One special character", _hasSpecial),
              ],

              const SizedBox(height: 20),

              if (widget.isSignIn)
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged:
                          (value) => setState(() => _rememberMe = value!),
                      activeColor: colorScheme.tertiary,
                    ),
                    Expanded(
                      child: Text(
                        'Remember me',
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.tertiary,
                  foregroundColor: colorScheme.onTertiary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child:
                    _isLoading
                        ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: colorScheme.onTertiary,
                            strokeWidth: 2,
                          ),
                        )
                        : Text(
                          widget.isSignIn ? 'Sign In' : 'Sign Up',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
