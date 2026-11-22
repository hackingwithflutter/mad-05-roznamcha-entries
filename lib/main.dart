import 'package:material_ui/material_ui.dart';

import 'app_flow.dart';

void main() {
  runApp(const RoznamchaApp());
}

/// The root widget. `MaterialApp` gives every screen below it the theme.
class RoznamchaApp extends StatelessWidget {
  const RoznamchaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roznamcha',
      // The design's seed colour. Every colour in the app is made from it.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0F766E)),
      ),
      // AppFlow shows the welcome screen until it knows the user's name, then
      // the home screen.
      home: const AppFlow(),
    );
  }
}
