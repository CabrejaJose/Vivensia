import 'package:material_ui/material_ui.dart';

import '../theme/vivensia_colors.dart';
import '../tokens/tokens.dart';

/// Bloque de carga con brillo suave. Se vuelve estático si el sistema
/// pide reducir animaciones.
class VivSkeleton extends StatefulWidget {
  const VivSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = VivRadius.smAll,
  });

  const VivSkeleton.circle({super.key, double size = 40})
    : width = size,
      height = size,
      borderRadius = VivRadius.pillAll;

  final double? width;
  final double height;
  final BorderRadius borderRadius;

  @override
  State<VivSkeleton> createState() => _VivSkeletonState();
}

class _VivSkeletonState extends State<VivSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: VivMotion.shimmer,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viv = context.vivColors;
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = _controller.value;
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: widget.borderRadius,
              gradient: LinearGradient(
                begin: Alignment(-1 + 3 * t - 1, 0),
                end: Alignment(-1 + 3 * t, 0),
                colors: [
                  viv.skeletonBase,
                  viv.skeletonHighlight,
                  viv.skeletonBase,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Esqueleto de un elemento de lista típico.
class VivSkeletonListTile extends StatelessWidget {
  const VivSkeletonListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: VivSpacing.lg,
        vertical: VivSpacing.md,
      ),
      child: Row(
        children: [
          VivSkeleton(width: 40, height: 40, borderRadius: VivRadius.mdAll),
          SizedBox(width: VivSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.7,
                  child: VivSkeleton(height: 14),
                ),
                SizedBox(height: VivSpacing.sm),
                FractionallySizedBox(
                  widthFactor: 0.45,
                  child: VivSkeleton(height: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
