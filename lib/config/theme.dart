import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  textTheme: GoogleFonts.workSansTextTheme(ThemeData.dark().textTheme),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Palette.primary,
    foregroundColor: Palette.foreground,
  ),
);
