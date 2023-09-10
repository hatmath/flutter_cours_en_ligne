import 'package:flutter/material.dart';
import 'config/myconfig.dart';
import 'config/mytheme.dart';
import "package:firebase_core/firebase_core.dart";
import "package:flutter/foundation.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (kIsWeb) {
    print("Flutter Web");    
    // Votre logique spécifique pour le Web ici
    // const FirebaseOptions webOption = FirebaseOptions(
    //   apiKey: "AIzaSyA4u2Z2oiqbOuyNpYWdWcGSqyNDhuK6xFY",
    //   authDomain: "exercices-flutter.firebaseapp.com",
    //   projectId: "exercices-flutter",
    //   storageBucket: "exercices-flutter.appspot.com",
    //   messagingSenderId: "399288472806",
    //   appId: "1:399288472806:web:a36ebd644c191217831727",
    //   measurementId: "G-N4YWPVQQCJ"
    // );
    const FirebaseOptions webOption = FirebaseOptions(
      apiKey: "AIzaSyDkQco911uDpu-tzwOHOwiOUI3EPy68hP4",
      authDomain: "cours-en-ligne-9a9e7.firebaseapp.com",
      projectId: "cours-en-ligne-9a9e7",
      storageBucket: "cours-en-ligne-9a9e7.appspot.com",
      messagingSenderId: "977641602143",
      appId: "1:977641602143:web:5380832f9e5b64b261efea",
      measurementId: "G-EQRNY54G6W"
    );
    await Firebase.initializeApp(
      options: webOption,
    );
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    print("Flutter Android");
    // Votre logique spécifique pour Android ici
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
      theme: MyTheme.whichThemeOptionToUse(ThemeOption.dark),
      home:PageView(
        // Utilisez la liste de pages de MyConfig
        children: MyConfig.pages,
      ),
    );
  }
}
