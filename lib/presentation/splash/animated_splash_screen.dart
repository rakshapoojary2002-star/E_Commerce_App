import 'package:e_commerce_app/presentation/auth/screens/auth_page.dart';
import 'package:e_commerce_app/presentation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/core/utils/flutter_secure.dart';

class AnimatedSplashScreen extends ConsumerStatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  ConsumerState<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends ConsumerState<AnimatedSplashScreen> {
  bool _showCart = false;

  Future<void> _checkAuthStatus() async {
    final token = await SecureStorage.getToken();
    if (mounted) {
      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(token: token)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AuthPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Animate(
              onComplete: (controller) {
                _checkAuthStatus();
              },
              effects: [
                // Bag slides in
                SlideEffect(
                  delay: 200.ms,
                  begin: const Offset(0, 2),
                  end: Offset.zero,
                  duration: 500.ms,
                  curve: Curves.easeOut,
                ),
                // Wait for items to fly in
                ThenEffect(delay: 1800.ms),
                // Bag transforms to cart
                CallbackEffect(
                  callback: (context) {
                    if (mounted) {
                      setState(() {
                        _showCart = true;
                      });
                    }
                  },
                ),
                // Confetti effect
                ShakeEffect(duration: 200.ms, hz: 8),
                ScaleEffect(
                  duration: 400.ms,
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                  curve: Curves.easeOut,
                ),
                ScaleEffect(
                  duration: 400.ms,
                  begin: const Offset(1.2, 1.2),
                  end: const Offset(1, 1),
                  curve: Curves.easeIn,
                ),
                ThenEffect(delay: 500.ms),
                FadeEffect(duration: 300.ms, end: 0.0),
              ],
              child: _showCart
                  ? const Icon(
                      Icons.shopping_cart,
                      size: 100,
                      color: Colors.blue,
                    )
                  : const Icon(
                      Icons.shopping_bag_outlined,
                      size: 100,
                      color: Colors.blue,
                    ),
            ),
            const SizedBox(height: 20),
            const Text(
              'E-Commerce App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
                .animate()
                .then(delay: 2200.ms)
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.5, end: 0.0, duration: 500.ms)
                .then(delay: 1300.ms)
                .fade(duration: 300.ms, end: 0.0),
          ],
        ),
      ),
    );
  }
}
