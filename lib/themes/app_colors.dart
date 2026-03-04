import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary        = Color(0xFF6C3CE1);
  static const Color primaryLight   = Color(0xFF8F6FEB);
  static const Color primaryDark    = Color(0xFF4A1FBF);

  //  Secondary / Accent
  static const Color secondary      = Color(0xFF34C759);
  static const Color secondaryLight = Color(0xFF4DDBBA);
  static const Color secondaryDark  = Color(0xFF008F6B);
  static const Color purple  = Color(0xFFAF52DE);

  // Background Colors
  static const Color background     = Color(0xFFFFFFFF);
  static const Color backgroundBlue = Color(0xFF007AFF);
  static const Color backgroundGrey = Color(0xFFD9D9D9);
  static const Color backgroundOrange = Color(0xFFFF9500);
  static const Color backgroundOrange1 = Color(0x33FFA64C);
  static const Color backgroundRed = Color(0x29FF0000);
  static const Color backgroundRed1 = Color(0x1FFF0000);
  static const Color backgroundBlack = Color(0xFF000000);
  static const Color backgroundGreen = Color(0x2900FF88);
  static const Color backgroundGreen1 = Color(0x3376FF4C);
  static const Color backgroundBlack1 = Color(0xFF0F0F0F);
  static const Color backgroundAss = Color(0x853C3C3C);
  static const Color backgroundPurple = Color(0x338E4CFF);
  static const Color background1 = Color(0x334C7FFF);

  // Surface / Card
  static const Color surface        = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0x3C3C4333);
  static const Color surfaceVariant1 = Color(0x145B89FF);
  static const Color cardColor      = Color(0xFFE7E7E7);

  // Text Colors
  static const Color textPrimary    = Color(0xFF5B89FF);
  static const Color textSecondary  = Color(0xFF8F8F8F);
  static const Color textSecondary1  = Color(0xFF6A635C);
  static const Color textSecondary2  = Color(0xFFB3B3B3);
  static const Color textWhite      = Color(0xFFFFFFFF);
  static const Color textBlack  = Color(0xFF000000);
  static const Color textBlack1  = Color(0xFF3C3C3C);
  static const Color textBlack2  = Color(0xFF1F1F1F);

  // Border / Divider
  static const Color border         = Color(0xFF5C5C5C);
  static const Color borderRed         = Color(0xFFFF3B30);
  static const Color border1         = Color(0xFFE1BC54);
  static const Color divider        = Color(0xFFF3F4F6);

  // Status Colors
  static const Color success        = Color(0xFF22C55E);
  static const Color successLight   = Color(0xFFDCFCE7);
  static const Color error          = Color(0xFFEF4444);
  static const Color errorLight     = Color(0xFFFEE2E2);
  static const Color warning        = Color(0xFFF59E0B);
  static const Color warningLight   = Color(0xFFFEF3C7);
  static const Color info           = Color(0xFF5B89FF);
  static const Color infoLight      = Color(0xFFDBEAFE);

  // Shadow
  static const Color shadow         = Color(0x1A000000);
  static const Color shadowLight    = Color(0x0D000000);

  // Transparent
  static const Color transparent    = Colors.transparent;

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF2B2B2B), Color(0xFF000000)],
  );
}