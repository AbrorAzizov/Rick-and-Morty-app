import 'package:flutter/material.dart';

class AppColors {
  // 🌞 Light Theme Colors
  static const Color lightBackground = Colors.white;
  static const Color lightCard = Colors.white;
  static const Color lightShadow = Colors.grey;
  static const Color lightTextPrimary = Colors.black;
  static const Color lightTextSecondary = Color(0xFF6D6D6D);

  // 🌙 Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);
  static const Color darkShadow = Colors.black;
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFFB0B0B0);

  // 🧩 Status Colors
  static const Color alive = Colors.green;
  static const Color dead = Colors.redAccent;
  static const Color unknown = Colors.grey;

  // ⭐ Favorite Colors
  static const Color favoriteActive = Colors.amber;
  static const Color favoriteInactive = Colors.grey;

  // 🌀 Misc
  static const Color placeholder = Color(0xFFE0E0E0);
}
