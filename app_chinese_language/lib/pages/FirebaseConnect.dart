import 'package:app_chinese_language/pages/Home.dart';
import 'package:app_chinese_language/pages/aunthen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseConnect extends StatefulWidget {
  FirebaseConnect({Key key}) : super(key: key);

  @override
  _FirebaseConnectState createState() => _FirebaseConnectState();
}

class _FirebaseConnectState extends State<FirebaseConnect> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("ERROR"),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Authen();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
