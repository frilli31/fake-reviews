import 'package:fake_reviews/models/items_provider.dart';
import 'package:fake_reviews/models/log_recipient.dart';
import 'package:fake_reviews/screens/instruction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  //debugPrintGestureArenaDiagnostics = true;
  //debugPaintSizeEnabled = true;

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
          // In this sample app, CatalogModel never changes, so a simple Provider
          // is sufficient.
          Provider(create: (context) => ItemsProvider()),
          Provider(create: (context) => LogRecipient()),
        ],
        child: MaterialApp(
          title: 'Fake Review',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Instruction(index: 0),
        ));
  }
}
