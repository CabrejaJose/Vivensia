import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/design_system/design_system.dart';

/// Relación de contraste WCAG 2.x entre dos colores opacos.
double contrastRatio(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final (hi, lo) = la > lb ? (la, lb) : (lb, la);
  return (hi + 0.05) / (lo + 0.05);
}

/// WCAG AA: 4.5:1 texto normal; 3:1 componentes de interfaz y texto grande.
const double textAA = 4.5;
const double nonTextAA = 3.0;

void main() {
  for (final (name, theme) in [
    ('claro', VivensiaTheme.light),
    ('oscuro', VivensiaTheme.dark),
  ]) {
    final s = theme.colorScheme;
    final v = theme.extension<VivensiaColors>()!;

    final textPairs = <String, (Color, Color)>{
      'onPrimary/primary': (s.onPrimary, s.primary),
      'onPrimaryContainer/primaryContainer': (
        s.onPrimaryContainer,
        s.primaryContainer,
      ),
      'onSecondary/secondary': (s.onSecondary, s.secondary),
      'onSecondaryContainer/secondaryContainer': (
        s.onSecondaryContainer,
        s.secondaryContainer,
      ),
      'onTertiary/tertiary': (s.onTertiary, s.tertiary),
      'onTertiaryContainer/tertiaryContainer': (
        s.onTertiaryContainer,
        s.tertiaryContainer,
      ),
      'onError/error': (s.onError, s.error),
      'onErrorContainer/errorContainer': (s.onErrorContainer, s.errorContainer),
      'onSurface/surface': (s.onSurface, s.surface),
      'onSurfaceVariant/surface': (s.onSurfaceVariant, s.surface),
      'onSurface/surfaceContainerHighest': (
        s.onSurface,
        s.surfaceContainerHighest,
      ),
      'onInverseSurface/inverseSurface': (s.onInverseSurface, s.inverseSurface),
      'error/surface': (s.error, s.surface),
      'textPrimary/background': (v.textPrimary, v.background),
      'textSecondary/background': (v.textSecondary, v.background),
      'textSecondary/surface': (v.textSecondary, s.surface),
      'link/background': (v.link, v.background),
      'link/surface': (v.link, s.surface),
      'success/background': (v.success, v.background),
      'warning/background': (v.warning, v.background),
      'info/background': (v.info, v.background),
      'onSuccess/success': (v.onSuccess, v.success),
      'onSuccessContainer/successContainer': (
        v.onSuccessContainer,
        v.successContainer,
      ),
      'onWarningContainer/warningContainer': (
        v.onWarningContainer,
        v.warningContainer,
      ),
      'onInfoContainer/infoContainer': (v.onInfoContainer, v.infoContainer),
      'onGold/gold': (v.onGold, v.gold),
      'onGoldContainer/goldContainer': (v.onGoldContainer, v.goldContainer),
    };

    final nonTextPairs = <String, (Color, Color)>{
      'outline/surface': (s.outline, s.surface),
      'outline/background': (s.outline, v.background),
      'primary/background': (s.primary, v.background),
      'primary/surface': (s.primary, s.surface),
    };

    group('Contraste WCAG AA — tema $name', () {
      textPairs.forEach((pair, colors) {
        test('texto $pair ≥ $textAA', () {
          final ratio = contrastRatio(colors.$1, colors.$2);
          expect(
            ratio,
            greaterThanOrEqualTo(textAA),
            reason: '$pair = ${ratio.toStringAsFixed(2)}:1',
          );
        });
      });
      nonTextPairs.forEach((pair, colors) {
        test('interfaz $pair ≥ $nonTextAA', () {
          final ratio = contrastRatio(colors.$1, colors.$2);
          expect(
            ratio,
            greaterThanOrEqualTo(nonTextAA),
            reason: '$pair = ${ratio.toStringAsFixed(2)}:1',
          );
        });
      });
    });
  }
}
