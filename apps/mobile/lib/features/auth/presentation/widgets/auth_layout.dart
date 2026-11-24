import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../design_system/design_system.dart';

/// Estructura común de las pantallas de autenticación: contenido centrado,
/// desplazable y con ancho máximo legible.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.title,
    required this.children,
    super.key,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: context.canPop() ? AppBar() : null,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(VivSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(title, style: text.headlineLarge),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: VivSpacing.sm),
                      Text(
                        subtitle!,
                        style: text.bodyLarge?.copyWith(
                          color: context.vivColors.textSecondary,
                        ),
                      ),
                    ],
                    const SizedBox(height: VivSpacing.xl),
                    ...children,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
