import 'package:material_ui/material_ui.dart';

/// Familias tipográficas empaquetadas (ver ADR 0003).
abstract final class VivFonts {
  static const heading = 'Manrope';
  static const body = 'Inter';
}

/// Escala tipográfica: Manrope para display/headline/title,
/// Inter para cuerpo y etiquetas. Respeta el escalado de texto del sistema.
abstract final class VivensiaTypography {
  static TextTheme textTheme(Color color) {
    TextStyle h(
      double size,
      double height,
      FontWeight weight, [
      double ls = 0,
    ]) => TextStyle(
      fontFamily: VivFonts.heading,
      fontSize: size,
      height: height / size,
      fontWeight: weight,
      letterSpacing: ls,
      color: color,
    );
    TextStyle b(
      double size,
      double height,
      FontWeight weight, [
      double ls = 0,
    ]) => TextStyle(
      fontFamily: VivFonts.body,
      fontSize: size,
      height: height / size,
      fontWeight: weight,
      letterSpacing: ls,
      color: color,
    );

    return TextTheme(
      displayLarge: h(48, 56, FontWeight.w800, -1),
      displayMedium: h(40, 48, FontWeight.w800, -0.75),
      displaySmall: h(34, 42, FontWeight.w700, -0.5),
      headlineLarge: h(30, 38, FontWeight.w700, -0.25),
      headlineMedium: h(26, 34, FontWeight.w700),
      headlineSmall: h(22, 30, FontWeight.w700),
      titleLarge: h(20, 28, FontWeight.w700),
      titleMedium: h(17, 24, FontWeight.w600),
      titleSmall: h(15, 22, FontWeight.w600),
      bodyLarge: b(16, 24, FontWeight.w400),
      bodyMedium: b(14, 20, FontWeight.w400),
      bodySmall: b(12, 16, FontWeight.w400, 0.1),
      labelLarge: b(15, 20, FontWeight.w600, 0.1),
      labelMedium: b(13, 18, FontWeight.w500, 0.2),
      labelSmall: b(11, 16, FontWeight.w600, 0.6),
    );
  }
}
