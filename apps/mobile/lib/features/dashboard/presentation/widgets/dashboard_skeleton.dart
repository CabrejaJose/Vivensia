import 'package:material_ui/material_ui.dart';

import '../../../../design_system/design_system.dart';

/// Marcador de carga con la forma del dashboard.
class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: VivSpacing.lg,
      children: [
        VivSkeleton(width: 140, height: 14),
        VivSkeleton(width: 220, height: 32),
        VivSkeleton(height: 160, borderRadius: VivRadius.xlAll),
        VivSkeleton(width: 180, height: 20),
        Row(
          spacing: VivSpacing.md,
          children: [
            Expanded(
              child: VivSkeleton(height: 120, borderRadius: VivRadius.xlAll),
            ),
            Expanded(
              child: VivSkeleton(height: 120, borderRadius: VivRadius.xlAll),
            ),
          ],
        ),
        Row(
          spacing: VivSpacing.md,
          children: [
            Expanded(
              child: VivSkeleton(height: 120, borderRadius: VivRadius.xlAll),
            ),
            Expanded(
              child: VivSkeleton(height: 120, borderRadius: VivRadius.xlAll),
            ),
          ],
        ),
      ],
    );
  }
}
