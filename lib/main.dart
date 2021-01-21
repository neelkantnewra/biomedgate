import 'package:biomedgate/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() {
  runApp(MyApp());
  FirebaseAdMob.instance
      .initialize(appId: "ca-app-pub-1433276656379191~5191252356");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Biomedical Gate",
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Splashscreen(),
    );
  }
}
