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
import '../widgets/auth_layout.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _submitting = false;
  bool _confirmationSent = false;
  AuthFailure? _failure;

  @override
  void dispose() {
    _name.dispose();
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
      final outcome = await ref
          .read(authActionsProvider)
          .signUp(
            email: _email.text,
            password: _password.text,
            displayName: _name.text,
            locale: Localizations.localeOf(context).languageCode,
          );
      TextInput.finishAutofillContext();
      if (outcome == SignUpOutcome.confirmationRequired && mounted) {
        setState(() => _confirmationSent = true);
      }
    } on AuthFailure catch (failure) {
      if (mounted) setState(() => _failure = failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (_confirmationSent) {
      return AuthLayout(
        title: l10n.confirmEmailTitle,
        children: [
          VivNotice(
            message: l10n.confirmEmailMessage,
            tone: VivNoticeTone.success,
          ),
          const SizedBox(height: VivSpacing.xl),
          VivButton(
            label: l10n.backToSignIn,
            expand: true,
            onPressed: () => context.go(AppRoutes.signIn),
          ),
        ],
      );
    }

    return AuthLayout(
      title: l10n.signUpTitle,
      subtitle: l10n.signUpSubtitle,
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: VivSpacing.lg,
            children: [
              VivTextField(
                label: l10n.displayNameLabel,
                helperText: l10n.displayNameHelper,
                controller: _name,
                prefixIcon: LucideIcons.user,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                enabled: !_submitting,
                validator: (v) =>
                    l10n.displayNameError(validateDisplayName(v ?? '')),
              ),
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
                helperText: l10n.passwordRulesHelper(minPasswordLength),
                controller: _password,
                showPasswordLabel: l10n.showPassword,
                hidePasswordLabel: l10n.hidePassword,
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.done,
                enabled: !_submitting,
                onSubmitted: (_) => _submit(),
                validator: (v) =>
                    l10n.passwordError(validateNewPassword(v ?? '')),
              ),
            ],
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
          label: _submitting ? l10n.signingUp : l10n.signUpAction,
          isLoading: _submitting,
          expand: true,
          onPressed: _submit,
        ),
        const SizedBox(height: VivSpacing.md),
        VivButton(
          label: l10n.haveAccountPrompt,
          variant: VivButtonVariant.tertiary,
          expand: true,
          onPressed: _submitting
              ? null
              : () => context.pushReplacement(AppRoutes.signIn),
        ),
      ],
    );
  }
}
