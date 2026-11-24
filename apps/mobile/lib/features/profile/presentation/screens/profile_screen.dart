import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/domain/auth_status.dart';
import '../../../auth/domain/auth_validators.dart';
import '../../../auth/presentation/auth_messages.dart';
import '../../application/profile_providers.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../language_options.dart';

/// Edición del perfil: nombre visible e idioma. El email es de solo lectura.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(myProfileProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: SafeArea(
        child: switch (profile) {
          AsyncData(value: final UserProfile p) => _ProfileForm(profile: p),
          AsyncError() || AsyncData() => VivErrorState(
            title: l10n.errorGenericTitle,
            message: l10n.errorGenericMessage,
            retryLabel: l10n.retry,
            onRetry: () => ref.invalidate(myProfileProvider),
          ),
          _ => VivLoadingState(label: l10n.loading),
        },
      ),
    );
  }
}

class _ProfileForm extends ConsumerStatefulWidget {
  const _ProfileForm({required this.profile});

  final UserProfile profile;

  @override
  ConsumerState<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends ConsumerState<_ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.profile.displayName);
  late String _language = widget.profile.locale;
  bool _saving = false;
  bool? _saved;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _saved = null;
    });
    try {
      await ref
          .read(profileActionsProvider)
          .update(displayName: _name.text, locale: _language);
      if (mounted) setState(() => _saved = true);
    } on ProfileFailure {
      if (mounted) setState(() => _saved = false);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final status = ref.watch(authStatusProvider).value;
    final email = status is AuthSignedIn ? status.user.email : null;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: VivSize.maxContentWidth),
        child: ListView(
          padding: const EdgeInsets.all(VivSpacing.screenGutter),
          children: [
            Form(
              key: _formKey,
              child: VivTextField(
                label: l10n.displayNameLabel,
                helperText: l10n.displayNameHelper,
                controller: _name,
                prefixIcon: LucideIcons.user,
                enabled: !_saving,
                validator: (v) =>
                    l10n.displayNameError(validateDisplayName(v ?? '')),
              ),
            ),
            const SizedBox(height: VivSpacing.xl),
            VivSectionHeader(title: l10n.languageLabel),
            const SizedBox(height: VivSpacing.sm),
            VivSegmentedControl<String>(
              options: languageOptions(l10n),
              selected: _language,
              onChanged: (v) => setState(() => _language = v),
            ),
            if (email != null) ...[
              const SizedBox(height: VivSpacing.xl),
              VivSectionHeader(title: l10n.fieldEmailLabel),
              VivCard(
                padding: const EdgeInsets.symmetric(vertical: VivSpacing.sm),
                child: VivListTile(icon: LucideIcons.mail, title: email),
              ),
            ],
            if (_saved != null) ...[
              const SizedBox(height: VivSpacing.lg),
              VivNotice(
                message: _saved! ? l10n.profileSaved : l10n.profileSaveError,
                tone: _saved! ? VivNoticeTone.success : VivNoticeTone.error,
              ),
            ],
            const SizedBox(height: VivSpacing.xl),
            VivButton(
              label: _saving ? l10n.savingProfile : l10n.saveChanges,
              isLoading: _saving,
              expand: true,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
