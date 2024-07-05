import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_book/shared/theme/style.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Color? suffixIconColor;
  final String label;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;
  final bool enabled;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final String? initialValue;
  final Widget? prefixIcon;
  final String? errorText;

  const CustomTextField({
    super.key,
    this.keyboardType,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.controller,
    this.validator,
    this.isReadOnly = false,
    this.onTap,
    this.enabled = true,
    required this.label,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.suffixIconColor,
    this.maxLines = 1,
    this.initialValue,
    this.prefixIcon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        onTap: onTap,
        textCapitalization: keyboardType == TextInputType.emailAddress
            ? TextCapitalization.none
            : TextCapitalization.sentences,
        enabled: enabled,
        validator: validator,
        controller: controller,
        textAlign: textAlign,
        readOnly: isReadOnly,
        maxLines: maxLines,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.w500),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        decoration: InputDecoration(
          errorText: errorText,
          prefixIcon: prefixIcon,
          fillColor: kTextFieldColor,
          filled: true,
          isDense: true,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: kTextFieldPrefixColor),
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor ?? kTextFieldPrefixColor,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: Theme.of(context).textTheme.displaySmall,
          labelText: label,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: kPrimaryTextColor, fontWeight: FontWeight.w600),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200, width: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200, width: 0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
