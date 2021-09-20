import 'package:app_chinese_language/pages/FirebaseConnect.dart';
import 'package:app_chinese_language/pages/router.dart';
import 'package:flutter/material.dart';

String initRoute = '/authen';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseConnect(),
      routes: map,
    );
  }
}
