import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pulseboard_frontend/core/router/app_router.dart';
import 'package:pulseboard_frontend/core/theme/light_theme.dart';
import 'package:pulseboard_frontend/core/theme/dark_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: LightTheme.theme,
      darkTheme: DarkTheme.theme,
      themeMode: ThemeMode.dark,
    );
  }
}
