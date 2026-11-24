import 'package:flutter/painting.dart';

/// Paleta primitiva de Vivensia.
///
/// **No usar directamente en pantallas.** Las pantallas consumen colores
/// semánticos a través de `Theme.of(context).colorScheme` y
/// `context.vivColors` (ver `theme/vivensia_colors.dart`).
abstract final class VivensiaPalette {
  // ── Marca (definidos por producto) ─────────────────────────────
  static const green600 = Color(0xFF527A65); // Verde principal
  static const sage400 = Color(0xFF7FA68A); // Verde salvia (decorativo)
  static const cream50 = Color(0xFFF7F5EF); // Crema
  static const terracotta400 = Color(0xFFC9816C); // Terracota (decorativo)
  static const green900 = Color(0xFF27352E); // Verde profundo
  static const gold400 = Color(0xFFD6AC60); // Dorado suave
  static const white = Color(0xFFFFFFFF);
  static const sage100 = Color(0xFFDCE8DF); // Salvia clara
  static const green950 = Color(0xFF141C18); // Fondo oscuro

  // ── Derivados para accesibilidad (contraste WCAG AA verificado) ─
  static const green700 = Color(0xFF3F6150); // texto/acento verde sobre crema
  static const green300 = Color(0xFF8DBA9C); // primario en tema oscuro
  static const green800 = Color(0xFF2F4A3C); // contenedor primario oscuro
  static const green100 = Color(0xFFCFE5D6); // texto sobre contenedor oscuro
  static const sage50 = Color(0xFFEAF1EC);
  static const terracotta600 = Color(0xFFA35F4B); // terciario con texto blanco
  static const terracotta300 = Color(0xFFE3A28E); // terciario en tema oscuro
  static const terracotta100 = Color(0xFFF6E1D9);
  static const terracotta900 = Color(0xFF3A1E15);
  static const terracotta800 = Color(0xFF5A3326);

  // ── Neutros cálidos ────────────────────────────────────────────
  static const neutral50 = Color(0xFFFBFAF6);
  static const neutral100 = Color(0xFFF0EEE6);
  static const neutral150 = Color(0xFFEAE7DE);
  static const neutral200 = Color(0xFFE2DED3);
  static const neutral300 = Color(0xFFD5D9D2);
  static const neutral500 = Color(0xFF7A8A81);
  static const neutral600 = Color(0xFF5C6B63);
  static const neutralDark100 = Color(0xFFE9EEE9);
  static const neutralDark300 = Color(0xFFA9B6AE);
  static const neutralDark500 = Color(0xFF7D8E85);
  static const neutralDark700 = Color(0xFF3A4741);
  static const neutralDark800 = Color(0xFF2A3530);
  static const neutralDark850 = Color(0xFF232E28);
  static const neutralDark900 = Color(0xFF1C2621);

  // ── Estados ────────────────────────────────────────────────────
  static const red700 = Color(0xFFB3261E);
  static const red100 = Color(0xFFF9DEDC);
  static const red900 = Color(0xFF410E0B);
  static const red200 = Color(0xFFF2B8B5);
  static const red800 = Color(0xFF601410);
  static const red850 = Color(0xFF5C1F1A);
  static const success700 = Color(0xFF2E6B45);
  static const success100 = Color(0xFFDCEFE2);
  static const success300 = Color(0xFF8FD1A6);
  static const success850 = Color(0xFF1F3B2A);
  static const warning700 = Color(0xFF7A5200);
  static const warning100 = Color(0xFFF8E8C8);
  static const warning300 = Color(0xFFE9C46A);
  static const warning850 = Color(0xFF3F3216);
  static const info700 = Color(0xFF2F5F8A);
  static const info100 = Color(0xFFDDE9F5);
  static const info300 = Color(0xFF9CC3E8);
  static const info850 = Color(0xFF1C3146);
  static const gold800 = Color(0xFF5E4718);
  static const gold850 = Color(0xFF3B3018);
}
