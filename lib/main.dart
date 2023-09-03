import 'package:flutter/material.dart';
import 'view/myhomepage.dart';
import 'theme/mytheme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Flutter App',
      theme: MyTheme.whichThemeOptionToUse(ThemeOption.dark),
      home: MyHomePage(),
    );
  }
}
