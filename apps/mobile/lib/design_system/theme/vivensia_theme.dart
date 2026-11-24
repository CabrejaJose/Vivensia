import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../tokens/tokens.dart';
import '../typography/vivensia_typography.dart';
import 'vivensia_color_schemes.dart';
import 'vivensia_colors.dart';

/// Temas claro y oscuro de Vivensia sobre Material 3, personalizados para
/// evitar la apariencia Material por defecto.
abstract final class VivensiaTheme {
  static ThemeData get light =>
      _build(VivensiaColorSchemes.light, VivensiaColors.light);

  static ThemeData get dark =>
      _build(VivensiaColorSchemes.dark, VivensiaColors.dark);

  static ThemeData _build(ColorScheme scheme, VivensiaColors viv) {
    final text = VivensiaTypography.textTheme(viv.textPrimary);
    final isDark = scheme.brightness == Brightness.dark;

    const buttonShape = RoundedRectangleBorder(borderRadius: VivRadius.lgAll);
    const buttonSize = Size(VivSize.minTouchTarget, VivSize.buttonHeight);
    const buttonPadding = EdgeInsets.symmetric(horizontal: VivSpacing.xl);

    OutlineInputBorder inputBorder(
      Color color, [
      double width = VivSize.borderThin,
    ]) => OutlineInputBorder(
      borderRadius: VivRadius.mdAll,
      borderSide: BorderSide(color: color, width: width),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: viv.background,
      canvasColor: viv.background,
      fontFamily: VivFonts.body,
      textTheme: text,
      extensions: [viv],
      splashFactory: InkSparkle.splashFactory,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (_) =>
            const Icon(LucideIcons.arrowLeft, size: VivSize.iconLg),
        closeButtonIconBuilder: (_) =>
            const Icon(LucideIcons.x, size: VivSize.iconLg),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: VivSize.borderThin,
        space: VivSpacing.lg,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: viv.background,
        foregroundColor: viv.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: buttonSize,
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: buttonSize,
          padding: buttonPadding,
          shape: buttonShape,
          foregroundColor: viv.link,
          side: BorderSide(color: scheme.outline),
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(
            VivSize.minTouchTarget,
            VivSize.minTouchTarget,
          ),
          shape: buttonShape,
          foregroundColor: viv.link,
          textStyle: text.labelLarge,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size.square(VivSize.minTouchTarget),
          foregroundColor: viv.textPrimary,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? scheme.surfaceContainerHigh : scheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: VivSpacing.lg,
          vertical: VivSpacing.lg,
        ),
        labelStyle: text.bodyLarge?.copyWith(color: viv.textSecondary),
        floatingLabelStyle: text.bodyMedium?.copyWith(color: viv.link),
        hintStyle: text.bodyLarge?.copyWith(color: viv.textSecondary),
        helperStyle: text.bodySmall?.copyWith(color: viv.textSecondary),
        errorStyle: text.bodySmall?.copyWith(color: scheme.error),
        prefixIconColor: viv.textSecondary,
        suffixIconColor: viv.textSecondary,
        border: inputBorder(scheme.outlineVariant),
        enabledBorder: inputBorder(scheme.outline),
        focusedBorder: inputBorder(scheme.primary, VivSize.borderFocus),
        errorBorder: inputBorder(scheme.error),
        focusedErrorBorder: inputBorder(scheme.error, VivSize.borderFocus),
        disabledBorder: inputBorder(scheme.outlineVariant),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: VivRadius.xlAll,
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(borderRadius: VivRadius.xxlAll),
        titleTextStyle: text.headlineSmall,
        contentTextStyle: text.bodyLarge?.copyWith(color: viv.textSecondary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: scheme.surface,
        showDragHandle: true,
        dragHandleColor: scheme.outlineVariant,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(VivRadius.xxl),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primaryContainer,
        elevation: 0,
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => text.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? viv.textPrimary
                : viv.textSecondary,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w500,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: VivSize.iconLg,
            color: states.contains(WidgetState.selected)
                ? scheme.onPrimaryContainer
                : viv.textSecondary,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: const RoundedRectangleBorder(borderRadius: VivRadius.pillAll),
        side: BorderSide(color: scheme.outlineVariant),
        backgroundColor: scheme.surface,
        selectedColor: scheme.primaryContainer,
        labelStyle: text.labelMedium?.copyWith(color: viv.textPrimary),
        padding: const EdgeInsets.symmetric(horizontal: VivSpacing.md),
        showCheckmark: false,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          minimumSize: const Size(
            VivSize.minTouchTarget,
            VivSize.minTouchTarget,
          ),
          selectedBackgroundColor: scheme.primaryContainer,
          selectedForegroundColor: scheme.onPrimaryContainer,
          foregroundColor: viv.textPrimary,
          side: BorderSide(color: scheme.outline),
          textStyle: text.labelMedium,
        ),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(horizontal: VivSpacing.lg),
        minVerticalPadding: VivSpacing.md,
        minTileHeight: 56,
        shape: const RoundedRectangleBorder(borderRadius: VivRadius.lgAll),
        titleTextStyle: text.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        subtitleTextStyle: text.bodyMedium?.copyWith(color: viv.textSecondary),
        iconColor: viv.textSecondary,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.primaryContainer,
        circularTrackColor: Colors.transparent,
        linearMinHeight: 8,
        borderRadius: VivRadius.pillAll,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: text.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
        shape: const RoundedRectangleBorder(borderRadius: VivRadius.lgAll),
      ),
      switchTheme: SwitchThemeData(
        trackOutlineColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? Colors.transparent
              : scheme.outline,
        ),
      ),
    );
  }
}
