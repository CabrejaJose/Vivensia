import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../tokens/tokens.dart';

/// Campo de texto de Vivensia.
///
/// Para contraseñas usar [VivTextField.password], que añade el botón de
/// mostrar/ocultar con etiquetas accesibles.
class VivTextField extends StatefulWidget {
  const VivTextField({
    required this.label,
    super.key,
    this.controller,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.autofillHints,
    this.inputFormatters,
    this.maxLines = 1,
  }) : _isPassword = false,
       showPasswordLabel = null,
       hidePasswordLabel = null;

  const VivTextField.password({
    required this.label,
    required String this.showPasswordLabel,
    required String this.hidePasswordLabel,
    super.key,
    this.controller,
    this.hint,
    this.helperText,
    this.errorText,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.enabled = true,
    this.autofillHints = const [AutofillHints.password],
  }) : _isPassword = true,
       prefixIcon = LucideIcons.lock,
       keyboardType = TextInputType.visiblePassword,
       inputFormatters = null,
       maxLines = 1;

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final String? showPasswordLabel;
  final String? hidePasswordLabel;
  final bool _isPassword;

  @override
  State<VivTextField> createState() => _VivTextFieldState();
}

class _VivTextFieldState extends State<VivTextField> {
  late bool _obscured = widget._isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      obscureText: _obscured,
      enableSuggestions: !widget._isPassword,
      autocorrect: !widget._isPassword,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      autofillHints: widget.autofillHints,
      inputFormatters: widget.inputFormatters,
      maxLines: widget._isPassword ? 1 : widget.maxLines,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        errorMaxLines: 3,
        helperMaxLines: 3,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(widget.prefixIcon, size: VivSize.iconMd),
        suffixIcon: widget._isPassword
            ? IconButton(
                tooltip: _obscured
                    ? widget.showPasswordLabel
                    : widget.hidePasswordLabel,
                icon: Icon(
                  _obscured ? LucideIcons.eye : LucideIcons.eyeOff,
                  size: VivSize.iconMd,
                ),
                onPressed: () => setState(() => _obscured = !_obscured),
              )
            : null,
      ),
    );
  }
}
