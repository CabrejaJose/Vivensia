import 'package:flutter/services.dart';
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

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _submitting = false;
  AuthFailure? _failure;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;
    setState(() {
      _submitting = true;
      _failure = null;
    });
    try {
      await ref
          .read(authActionsProvider)
          .signIn(email: _email.text, password: _password.text);
      TextInput.finishAutofillContext();
      // La navegación la resuelve la guardia del router al cambiar la sesión.
    } on AuthFailure catch (failure) {
      if (mounted) setState(() => _failure = failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return VivFormLayout(
      title: l10n.signInTitle,
      subtitle: l10n.signInSubtitle,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: VivSpacing.lg,
            children: [
              VivTextField(
                label: l10n.fieldEmailLabel,
                controller: _email,
                prefixIcon: LucideIcons.mail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                enabled: !_submitting,
                validator: (v) => l10n.emailError(validateEmail(v ?? '')),
              ),
              VivTextField.password(
                label: l10n.fieldPasswordLabel,
                controller: _password,
                showPasswordLabel: l10n.showPassword,
                hidePasswordLabel: l10n.hidePassword,
                textInputAction: TextInputAction.done,
                enabled: !_submitting,
                onSubmitted: (_) => _submit(),
                validator: (v) =>
                    l10n.passwordError(validatePasswordPresent(v ?? '')),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: VivButton(
            label: l10n.forgotPasswordLink,
            variant: VivButtonVariant.tertiary,
            compact: true,
            onPressed: _submitting
                ? null
                : () => context.push(AppRoutes.forgotPassword),
          ),
        ),
        if (_failure != null) ...[
          const SizedBox(height: VivSpacing.sm),
          VivNotice(
            message: l10n.authFailure(_failure!),
            tone: VivNoticeTone.error,
          ),
        ],
        const SizedBox(height: VivSpacing.xl),
        VivButton(
          label: _submitting ? l10n.signingIn : l10n.signInAction,
          isLoading: _submitting,
          expand: true,
          onPressed: _submit,
        ),
        const SizedBox(height: VivSpacing.md),
        VivButton(
          label: l10n.noAccountPrompt,
          variant: VivButtonVariant.tertiary,
          expand: true,
          onPressed: _submitting
              ? null
              : () => context.pushReplacement(AppRoutes.signUp),
        ),
      ],
    );
  }
}
