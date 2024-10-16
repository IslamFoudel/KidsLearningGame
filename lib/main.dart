import 'package:flutter/material.dart';
import 'package:kids_learning_game/screens/home.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Home.ROUTE,
      routes: {
        Home.ROUTE: (_) => Home(),
      },
    );
  }
}
