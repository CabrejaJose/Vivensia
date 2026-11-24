import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../application/auth_providers.dart';
import '../../domain/auth_failure.dart';
import '../../domain/auth_validators.dart';
import '../auth_messages.dart';
import '../widgets/auth_layout.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  bool _submitting = false;
  bool _sent = false;
  AuthFailure? _failure;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _failure = null;
    });
    try {
      await ref.read(authActionsProvider).sendPasswordReset(email: _email.text);
      if (mounted) setState(() => _sent = true);
    } on AuthFailure catch (failure) {
      if (mounted) setState(() => _failure = failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AuthLayout(
      title: l10n.forgotPasswordTitle,
      subtitle: _sent ? null : l10n.forgotPasswordSubtitle,
      children: [
        if (_sent) ...[
          VivNotice(
            message: l10n.resetLinkSentMessage,
            tone: VivNoticeTone.success,
          ),
          const SizedBox(height: VivSpacing.xl),
          VivButton(
            label: l10n.backToSignIn,
            expand: true,
            onPressed: () => context.go(AppRoutes.signIn),
          ),
        ] else ...[
          Form(
            key: _formKey,
            child: VivTextField(
              label: l10n.fieldEmailLabel,
              controller: _email,
              prefixIcon: LucideIcons.mail,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.email],
              enabled: !_submitting,
              onSubmitted: (_) => _submit(),
              validator: (v) => l10n.emailError(validateEmail(v ?? '')),
            ),
          ),
          if (_failure != null) ...[
            const SizedBox(height: VivSpacing.lg),
            VivNotice(
              message: l10n.authFailure(_failure!),
              tone: VivNoticeTone.error,
            ),
          ],
          const SizedBox(height: VivSpacing.xl),
          VivButton(
            label: _submitting ? l10n.sendingResetLink : l10n.sendResetLink,
            isLoading: _submitting,
            expand: true,
            onPressed: _submit,
          ),
        ],
      ],
    );
  }
}
