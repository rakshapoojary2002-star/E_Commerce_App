import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/auth_card.dart';
import '../widgets/header_widget.dart';
import '../widgets/toggle_button.dart';
import '../widgets/wave_background.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  bool isSignIn = true;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  void toggleAuthMode() => setState(() => isSignIn = !isSignIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WaveBackground(animation: _waveController),
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      HeaderWidget(),
                      SizedBox(height: 40.h),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: AuthCard(
                            key: ValueKey(isSignIn),
                            isSignIn: isSignIn,
                            onSignUpSuccess:
                                () => setState(() => isSignIn = true),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ToggleButton(
                        isSignIn: isSignIn,
                        toggleAuthMode: toggleAuthMode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
