import 'package:e_commerce_app/presentation/auth/screens/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_commerce_app/core/theme/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialTheme = MaterialTheme(Theme.of(context).textTheme);

    return MaterialApp(
      title: 'E-Commerce App',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.system,
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
