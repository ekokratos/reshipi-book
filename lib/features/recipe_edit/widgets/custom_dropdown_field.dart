import 'package:flutter/material.dart';
import 'package:recipe_book/shared/theme/style.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;
  final T? dropdownValue;
  final FormFieldValidator<T>? validator;

  const CustomDropdownButton({
    Key? key,
    required this.label,
    required this.items,
    required this.onChanged,
    required this.dropdownValue,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: dropdownValue,
      validator: validator,
      decoration: InputDecoration(
        fillColor: kTextFieldColor,
        isDense: true,
        filled: true,
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
      isDense: true,
      items: items,
      onChanged: onChanged,
    );
  }
}
