import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
static _border ([Color color = AppPalette.bordercolor] )=> OutlineInputBorder(borderSide: BorderSide(color: color,
width: 3) );

  static final darkThemeMode = ThemeData.dark().copyWith(
scaffoldBackgroundColor: AppPalette.backgroundColor,
inputDecorationTheme: InputDecorationTheme(
  contentPadding: const EdgeInsets.all(27),

  enabledBorder: _border(), 
  focusedBorder: _border(AppPalette.gradient2),
),
  );
}    