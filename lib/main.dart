import 'package:e_commerce_app/core/theme/text_theme.dart';
import 'package:e_commerce_app/core/utils/flutter_secure.dart';
import 'package:e_commerce_app/presentation/auth/screens/auth_page.dart';
import 'package:e_commerce_app/presentation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/core/theme/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Check token from secure storage
  final token = await SecureStorage.getToken();

  runApp(ProviderScope(child: MyApp(initialToken: token)));
}

class MyApp extends ConsumerWidget {
  final String? initialToken;
  const MyApp({super.key, this.initialToken});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = createTextTheme(context, "Lato", "Poppins");
    final materialTheme = MaterialTheme(textTheme);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          title: 'E-Commerce App',
          theme: materialTheme.light(),
          darkTheme: materialTheme.dark(),
          themeMode: ThemeMode.system,
          // 🔹 If token exists → go to HomeScreen, else AuthPage
          home:
              initialToken != null
                  ? HomeScreen(token: initialToken!)
                  : AuthPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
