import 'package:material_ui/material_ui.dart';

import '../tokens/color_tokens.dart';

/// Colores semánticos que Material 3 no cubre: fondo de pantalla,
/// estados (éxito, aviso, información) y el dorado de logros.
@immutable
class VivensiaColors extends ThemeExtension<VivensiaColors> {
  const VivensiaColors({
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.link,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.info,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.gold,
    required this.onGold,
    required this.goldContainer,
    required this.onGoldContainer,
    required this.decorativeSage,
    required this.decorativeTerracotta,
    required this.skeletonBase,
    required this.skeletonHighlight,
  });

  /// Fondo de las pantallas (crema en claro, verde muy oscuro en oscuro).
  final Color background;
  final Color textPrimary;
  final Color textSecondary;

  /// Texto interactivo sobre fondo o superficie.
  final Color link;
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color info;
  final Color infoContainer;
  final Color onInfoContainer;
  final Color gold;
  final Color onGold;
  final Color goldContainer;
  final Color onGoldContainer;

  /// Solo ilustraciones/decoración: no usar como color de texto.
  final Color decorativeSage;
  final Color decorativeTerracotta;
  final Color skeletonBase;
  final Color skeletonHighlight;

  static const light = VivensiaColors(
    background: VivensiaPalette.cream50,
    textPrimary: VivensiaPalette.green900,
    textSecondary: VivensiaPalette.neutral600,
    link: VivensiaPalette.green700,
    success: VivensiaPalette.success700,
    onSuccess: VivensiaPalette.white,
    successContainer: VivensiaPalette.success100,
    onSuccessContainer: VivensiaPalette.success850,
    warning: VivensiaPalette.warning700,
    warningContainer: VivensiaPalette.warning100,
    onWarningContainer: VivensiaPalette.warning850,
    info: VivensiaPalette.info700,
    infoContainer: VivensiaPalette.info100,
    onInfoContainer: VivensiaPalette.info850,
    gold: VivensiaPalette.gold400,
    onGold: VivensiaPalette.green900,
    goldContainer: VivensiaPalette.warning100,
    onGoldContainer: VivensiaPalette.gold800,
    decorativeSage: VivensiaPalette.sage400,
    decorativeTerracotta: VivensiaPalette.terracotta400,
    skeletonBase: VivensiaPalette.neutral150,
    skeletonHighlight: VivensiaPalette.neutral50,
  );

  static const dark = VivensiaColors(
    background: VivensiaPalette.green950,
    textPrimary: VivensiaPalette.neutralDark100,
    textSecondary: VivensiaPalette.neutralDark300,
    link: VivensiaPalette.green300,
    success: VivensiaPalette.success300,
    onSuccess: VivensiaPalette.success850,
    successContainer: VivensiaPalette.success850,
    onSuccessContainer: VivensiaPalette.success100,
    warning: VivensiaPalette.warning300,
    warningContainer: VivensiaPalette.warning850,
    onWarningContainer: VivensiaPalette.warning100,
    info: VivensiaPalette.info300,
    infoContainer: VivensiaPalette.info850,
    onInfoContainer: VivensiaPalette.info100,
    gold: VivensiaPalette.gold400,
    onGold: VivensiaPalette.green950,
    goldContainer: VivensiaPalette.gold850,
    onGoldContainer: VivensiaPalette.warning100,
    decorativeSage: VivensiaPalette.sage400,
    decorativeTerracotta: VivensiaPalette.terracotta400,
    skeletonBase: VivensiaPalette.neutralDark850,
    skeletonHighlight: VivensiaPalette.neutralDark800,
  );

  @override
  VivensiaColors copyWith() => this;

  @override
  VivensiaColors lerp(VivensiaColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return VivensiaColors(
      background: l(background, other.background),
      textPrimary: l(textPrimary, other.textPrimary),
      textSecondary: l(textSecondary, other.textSecondary),
      link: l(link, other.link),
      success: l(success, other.success),
      onSuccess: l(onSuccess, other.onSuccess),
      successContainer: l(successContainer, other.successContainer),
      onSuccessContainer: l(onSuccessContainer, other.onSuccessContainer),
      warning: l(warning, other.warning),
      warningContainer: l(warningContainer, other.warningContainer),
      onWarningContainer: l(onWarningContainer, other.onWarningContainer),
      info: l(info, other.info),
      infoContainer: l(infoContainer, other.infoContainer),
      onInfoContainer: l(onInfoContainer, other.onInfoContainer),
      gold: l(gold, other.gold),
      onGold: l(onGold, other.onGold),
      goldContainer: l(goldContainer, other.goldContainer),
      onGoldContainer: l(onGoldContainer, other.onGoldContainer),
      decorativeSage: l(decorativeSage, other.decorativeSage),
      decorativeTerracotta: l(decorativeTerracotta, other.decorativeTerracotta),
      skeletonBase: l(skeletonBase, other.skeletonBase),
      skeletonHighlight: l(skeletonHighlight, other.skeletonHighlight),
    );
  }
}

extension VivensiaThemeContext on BuildContext {
  /// Colores semánticos adicionales de Vivensia.
  VivensiaColors get vivColors =>
      Theme.of(this).extension<VivensiaColors>() ?? VivensiaColors.light;
}
