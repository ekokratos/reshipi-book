import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_book/shared/theme/style.dart';

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
  final int? maxLines;

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
    this.suffixIconColor,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextFormField(
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
            .bodyText1!
            .copyWith(fontWeight: FontWeight.w500),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        decoration: InputDecoration(
          fillColor: kTextFieldColor,
          filled: true,
          isDense: true,
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
          suffixIcon: suffixIcon,
          suffixIconColor: suffixIconColor ?? kTextFieldPrefixColor,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelStyle: Theme.of(context).textTheme.headline3,
          labelText: label,
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: kPrimaryTextColor, fontWeight: FontWeight.w600),
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


          // prefixIcon: SizedBox(
          //   width: 110,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 15),
          //     child: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Text(
          //           label,
          //           style: Theme.of(context)
          //               .textTheme
          //               .bodyText1!
          //               .copyWith(color: kPrimaryTextColor),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),