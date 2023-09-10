
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

enum ThemeOption {
  dark,
  light,
}

class MyTheme {

  // Valeur par défault
  static ThemeData currentThemeData = darkTheme;

  static ThemeData whichThemeOptionToUse(ThemeOption option) { 
    switch (option) {
      case ThemeOption.dark:
        currentThemeData = darkTheme;
        break;
      case ThemeOption.light:
        currentThemeData = lightTheme;
        break;
    }
    return currentThemeData;
  }

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
}







  
