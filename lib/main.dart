import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_snake/routes.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Algo Snake',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        scaffoldBackgroundColor: const Color(0xFF92caf2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF92caf2),
          titleTextStyle: TextStyle(color: Colors.black),
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
