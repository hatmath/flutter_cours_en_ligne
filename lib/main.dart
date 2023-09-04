import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/myconfig.dart';
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
      title: MyConfig.mainAppTitle,
      theme: MyTheme.whichThemeOptionToUse(ThemeOption.dark),
      home:PageView(
        // Utilisez la liste de pages de MyConfig
        children: MyConfig.pages,
      ),
    );
  }
}
