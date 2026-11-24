import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/design_system/design_system.dart';

void main() {
  group('VivensiaTheme', () {
    test('claro usa la paleta de marca', () {
      final theme = VivensiaTheme.light;
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme.primary, VivensiaPalette.green600);
      expect(theme.scaffoldBackgroundColor, VivensiaPalette.cream50);
      expect(theme.extension<VivensiaColors>(), VivensiaColors.light);
    });

    test('oscuro usa el fondo oscuro de marca', () {
      final theme = VivensiaTheme.dark;
      expect(theme.brightness, Brightness.dark);
      expect(theme.scaffoldBackgroundColor, VivensiaPalette.green950);
      expect(theme.extension<VivensiaColors>(), VivensiaColors.dark);
    });

    test('títulos en Manrope y contenido en Inter', () {
      final text = VivensiaTheme.light.textTheme;
      for (final style in [
        text.displaySmall,
        text.headlineLarge,
        text.titleLarge,
        text.titleMedium,
      ]) {
        expect(style?.fontFamily, VivFonts.heading);
      }
      for (final style in [text.bodyLarge, text.bodyMedium, text.labelLarge]) {
        expect(style?.fontFamily, VivFonts.body);
      }
    });

    test('los tokens de escala son los definidos por producto', () {
      expect(
        [
          VivSpacing.xs,
          VivSpacing.sm,
          VivSpacing.md,
          VivSpacing.lg,
          VivSpacing.xl,
          VivSpacing.xxl,
        ],
        [4, 8, 12, 16, 24, 32],
      );
      expect(
        [VivRadius.sm, VivRadius.md, VivRadius.lg, VivRadius.xl, VivRadius.xxl],
        [8, 12, 16, 24, 32],
      );
    });

    test('VivensiaColors.lerp interpola entre temas', () {
      final mid = VivensiaColors.light.lerp(VivensiaColors.dark, 0.5);
      expect(mid.background, isNot(VivensiaColors.light.background));
      expect(VivensiaColors.light.lerp(null, 0.5), VivensiaColors.light);
    });
  });

  group('ThemeModeController', () {
    test('por defecto sigue al sistema', () {
      expect(ThemeModeController().build(), ThemeMode.system);
    });
  });
}
