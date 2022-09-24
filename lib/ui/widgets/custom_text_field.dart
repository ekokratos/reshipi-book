import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_book/ui/theme/style.dart';

class CustomTextField extends StatelessWidget {
  final String? prefixText;
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
  final String? initialValue;

  const CustomTextField({
    Key? key,
    this.keyboardType,
    this.inputFormatters,
    this.prefixText,
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
    this.initialValue,
    this.suffixIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
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
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.w700),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        decoration: InputDecoration(
          fillColor: kTextFieldColor,
          isDense: true,
          filled: true,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: kTextFieldPrefixColor),
          prefixText: prefixText,
          prefixStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: kTextFieldPrefixColor),
          prefixIcon: SizedBox(
            width: 120,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: kTextFieldPrefixColor),
                  ),
                ],
              ),
            ),
          ),
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor ?? kTextFieldPrefixColor,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(6),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 0.5),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 0.8),
            borderRadius: BorderRadius.circular(6),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
