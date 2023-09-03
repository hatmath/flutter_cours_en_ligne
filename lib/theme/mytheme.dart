
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

enum ThemeOption {
  mix,
  dark,
  light,
}

class MyTheme {

  static ThemeData whichThemeOptionToUse(ThemeOption option) {

    ThemeData darkThemeData = MyGlobalTheme.darkTheme;
    ThemeData lightThemeData = MyGlobalTheme.lightTheme;
    AppBarTheme currentAppBarTheme = MyAppBarTheme.appBarThemeExample;
    TabBarTheme currentTabBarTheme = MyTabBarTheme.tabBarThemeExample;  
    ThemeData mixThemeData = ThemeData(
      appBarTheme: currentAppBarTheme,
      tabBarTheme: currentTabBarTheme,
    );
    
    ThemeData currentThemeData;

    switch (option) {
      case ThemeOption.dark:
        currentThemeData = darkThemeData;
        break;
      case ThemeOption.light:
        currentThemeData = lightThemeData;
        break;
      case ThemeOption.mix:
        currentThemeData = mixThemeData;
        break;
    }

    return currentThemeData;

  }

}

class MyGlobalTheme {

  // Avec le package flex_color_scheme

  static final ThemeData lightTheme = FlexThemeData.light(
    scheme: FlexScheme.aquaBlue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 20,
    appBarOpacity: 0.95,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 20,
      blendOnColors: false,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  static ThemeData darkTheme = FlexThemeData.dark(
    scheme: FlexScheme.aquaBlue,
    surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
    blendLevel: 15,
    appBarStyle: FlexAppBarStyle.background,
    appBarOpacity: 0.90,
    subThemesData: const FlexSubThemesData(
      blendOnLevel: 30,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,    
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );
  
  // Uncomment this line if you want to let the device system mode control the theme mode
  // static ThemeMode themeMode = ThemeMode.system;

  // Le suite c'est si on ne veux pas utiliser le package flex_color_scheme
  static ThemeData basicThemeData = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

}

class MyAppBarTheme {
  static final AppBarTheme appBarThemeExample = AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 119, 69, 35), toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(
        color: Color.fromARGB(255, 147, 210, 214),
        fontSize: 20,
      ),
    ).bodyMedium, titleTextStyle: const TextTheme(
      titleLarge: TextStyle(
        color: Color.fromRGBO(195, 184, 204, 1),
        fontSize: 20,
      ),
    ).titleLarge,
    // Ajoutez d'autres propriétés de l'AppBarTheme ici
  );
}

class MyTabBarTheme {
  static const TabBarTheme tabBarThemeExample = TabBarTheme(
    labelColor: Color.fromARGB(255, 102, 16, 214),
    unselectedLabelColor: Color.fromARGB(255, 168, 28, 164),
    // Ajoutez d'autres propriétés du TabBarTheme ici
  );
}

class MyDrawerTheme {
  // static final DrawerTheme drawerTheme = DrawerTheme(
  //   // Propriétés spécifiques du DrawerTheme ici
  // );
}




  
