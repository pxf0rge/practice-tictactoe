import 'package:flutter/material.dart';

/// Arena-style palette for XOClash.
abstract final class AppColors {
  static const Color bgDeep = Color(0xFF0A0E17);
  static const Color bgMid = Color(0xFF151C2E);
  static const Color bgTop = Color(0xFF1F2A44);

  static const Color purple = Color(0xFFFF6B4A); // X accent (coral)
  static const Color blue = Color(0xFF3DDCFF); // O accent (cyan)
  static const Color accent = Color(0xFFF5C542); // CTA / highlight

  static const Color grey = Color(0xFFF2F5FA);
  static const Color lightGrey = Color(0xFF8B95A8);
  static const Color boxGrey = Color(0xFF1C2438);

  static const Color panel = Color(0x14FFFFFF);
  static const Color panelBorder = Color(0x22FFFFFF);
  static const Color success = Color(0xFF5CE88A);
  static const Color danger = Color(0xFFFF5C7A);

  static const LinearGradient arenaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [bgDeep, bgMid, bgTop],
    stops: [0.0, 0.55, 1.0],
  );

  static const LinearGradient xGlow = LinearGradient(
    colors: [Color(0xFFFF8A6B), purple],
  );

  static const LinearGradient oGlow = LinearGradient(
    colors: [Color(0xFF7AEAFF), blue],
  );

  static const LinearGradient ctaGradient = LinearGradient(
    colors: [Color(0xFFFFD56A), accent],
  );
}
