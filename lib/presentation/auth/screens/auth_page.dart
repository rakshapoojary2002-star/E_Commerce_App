import 'package:flutter/material.dart';
import 'package:e_commerce_app/presentation/auth/widgets/auth_card.dart';
import 'package:e_commerce_app/presentation/auth/widgets/header_widget.dart';
import 'package:e_commerce_app/presentation/auth/widgets/toggle_button.dart';
import 'package:e_commerce_app/presentation/auth/widgets/wave_painter.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  bool isSignIn = true;
  late AnimationController _animationController;
  late AnimationController _waveController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _waveController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  void toggleAuthMode() {
    setState(() => isSignIn = !isSignIn);
    _animationController.reset();
    _animationController.forward();
  }

  void switchToSignIn() {
    setState(() => isSignIn = true);
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.surfaceContainerLowest,
              Theme.of(context).colorScheme.surfaceContainer,
              Theme.of(context).colorScheme.surfaceContainerHigh,
            ],
          ),
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _waveController,
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter(_waveController.value),
                  size: Size.infinite,
                );
              },
            ),
            SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: Opacity(
                          opacity: _fadeAnimation.value,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 400),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                HeaderWidget(),
                                SizedBox(height: 40),

                                Expanded(
                                  child: AuthCard(
                                    isSignIn: isSignIn,
                                    onSignUpSuccess: switchToSignIn,
                                  ),
                                ),

                                SizedBox(height: 20),
                                ToggleButton(
                                  isSignIn: isSignIn,
                                  toggleAuthMode: toggleAuthMode,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
