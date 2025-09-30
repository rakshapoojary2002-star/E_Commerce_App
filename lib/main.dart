import 'package:e_commerce_app/core/theme/text_theme.dart';
import 'package:e_commerce_app/core/theme/theme.dart';
import 'package:e_commerce_app/presentation/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

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
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
