//   Projet: 	  Projet Final Flutter, Application de Cours en Ligne
//   Codeurs:	  Simon Turcotte (2395412) et Mathieu Hatin (2296939)
//   Cours: 		Apps multi (420-324-AH)
//   Date:		  15 septembre 2023

import 'package:flutter/material.dart';
import 'config/myconfig.dart';
import 'config/mytheme.dart';
import "package:firebase_core/firebase_core.dart";
import "package:flutter/foundation.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    print("Flutter Web");
    const FirebaseOptions webOption = FirebaseOptions(
        apiKey: "AIzaSyDkQco911uDpu-tzwOHOwiOUI3EPy68hP4",
        authDomain: "cours-en-ligne-9a9e7.firebaseapp.com",
        projectId: "cours-en-ligne-9a9e7",
        storageBucket: "cours-en-ligne-9a9e7.appspot.com",
        messagingSenderId: "977641602143",
        appId: "1:977641602143:web:5380832f9e5b64b261efea",
        measurementId: "G-EQRNY54G6W");
    await Firebase.initializeApp(
      options: webOption,
    );
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    print("Flutter Android");
    // Logique spécifique pour Android ici
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyConfig.mainAppTitle,
      theme: MyTheme.whichThemeOptionToUse(ThemeOption.light),
      home: PageView(
        // Utilisez la liste de pages de MyConfig
        children: MyConfig.pages,
      ),
    );
  }
}
