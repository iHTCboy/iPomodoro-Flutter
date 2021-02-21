import 'package:flutter/material.dart';

class AppColors {
  //主色
  static const Color PRIMARY_MAIN_COLOR = const Color(0xFFD74A49);
  static const Color PRIMARY_SUB_COLOR = const Color(0xFFDC5C5D);
  static const Color TIMER_MAIN_COLOR = const Color(0xFF4F97E0);
  static const Color TIMER_SUB_COLOR = const Color(0xFF579DE5);
  static const Color COUNTDOWN_MAIN_COLOR = const Color(0xFFFF8900);
  static const Color COUNTDOWN_SUB_COLOR = const Color(0xFFFF9F40);
  static const Color ME_MAIN_COLOR = const Color(0xFF007C21);
  static const Color ME_SUB_COLOR = const Color(0xFF248F40);

  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }
}