import 'package:flutter/material.dart';

import 'palette.dart';

final appTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Palette.background,
  appBarTheme: AppBarTheme(
    backgroundColor: Palette.background,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Palette.background,
  ),
  dividerColor: Palette.secondary,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Palette.primary,
    foregroundColor: Palette.foreground,
  ),
);
