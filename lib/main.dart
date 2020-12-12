import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pencil_reviews/providers/items_provider.dart';
import 'package:pencil_reviews/providers/log_provider.dart';
import 'package:pencil_reviews/screens/1_welcome_screen.dart';
import 'package:pencil_reviews/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => ItemsProvider()),
          Provider(create: (context) => LogProvider()),
        ],
        child: MaterialApp(
          title: 'Pencil Reviews',
          theme: AppTheme().lightTheme,
          home: WelcomeScreen(),
        ));
  }
}
