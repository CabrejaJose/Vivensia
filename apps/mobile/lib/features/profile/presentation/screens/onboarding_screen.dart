import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/domain/auth_validators.dart';
import '../../../auth/presentation/auth_messages.dart';
import '../../application/profile_providers.dart';
import '../../domain/repositories/profile_repository.dart';
import '../language_options.dart';

/// Completa el perfil (nombre e idioma) tras el registro.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  String? _language;
  bool _saving = false;
  bool _failed = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit(String language) async {
    if (_saving || !_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _failed = false;
    });
    try {
      await ref
          .read(profileActionsProvider)
          .update(displayName: _name.text, locale: language);
      // La guardia del router lleva a Inicio cuando el perfil está completo.
    } on ProfileFailure {
      if (mounted) setState(() => _failed = true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final language =
        _language ??
        currentLanguageCode(Localizations.localeOf(context).languageCode);
    return VivFormLayout(
      title: l10n.onboardingTitle,
      subtitle: l10n.onboardingSubtitle,
      children: [
        Form(
          key: _formKey,
          child: VivTextField(
            label: l10n.displayNameLabel,
            controller: _name,
            prefixIcon: LucideIcons.user,
            autofillHints: const [AutofillHints.name],
            textInputAction: TextInputAction.done,
            enabled: !_saving,
            onSubmitted: (_) => _submit(language),
            validator: (v) =>
                l10n.displayNameError(validateDisplayName(v ?? '')),
          ),
        ),
        const SizedBox(height: VivSpacing.xl),
        VivSectionHeader(title: l10n.languageLabel),
        const SizedBox(height: VivSpacing.sm),
        VivSegmentedControl<String>(
          options: languageOptions(l10n),
          selected: language,
          onChanged: (v) => setState(() => _language = v),
        ),
        if (_failed) ...[
          const SizedBox(height: VivSpacing.lg),
          VivNotice(message: l10n.profileSaveError, tone: VivNoticeTone.error),
        ],
        const SizedBox(height: VivSpacing.xxl),
        VivButton(
          label: _saving ? l10n.savingProfile : l10n.continueAction,
          isLoading: _saving,
          expand: true,
          onPressed: () => _submit(language),
        ),
      ],
    );
  }
}
