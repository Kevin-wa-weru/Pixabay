import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle body = TextStyle(fontSize: 16, color: Colors.white70);

  static const TextStyle bodyError = TextStyle(
    fontSize: 16,
    color: Colors.redAccent,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle caption = TextStyle(fontSize: 14, color: Colors.grey);

  static const TextStyle emptyStateTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle emptyStateSubtitle = TextStyle(
    fontSize: 15,
    color: Colors.white70,
  );

  static const TextStyle pageTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.tealAccent,
    letterSpacing: 1.2,
  );

  static const TextStyle input = TextStyle(fontSize: 16, color: Colors.white);

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyWhite = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
}
