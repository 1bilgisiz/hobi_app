import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainFormTextField extends StatelessWidget {
  final int maxLines;
  final int? minLines;
  final String hintText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final bool isSpaceAllowed;
  final bool obscureText;
  final bool enabled;
  const MainFormTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    required this.onChanged,
    this.suffixIcon,
    this.onTap,
    this.onFieldSubmitted,
    this.keyboardType,
    this.controller,
    this.maxLines = 1,
    this.minLines,
    this.isSpaceAllowed = true,
    this.obscureText = false,
    this.enabled = true, required initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: TextFormField(
        enabled: enabled,
        textAlignVertical: TextAlignVertical.center,
        obscureText: obscureText,
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
        maxLines: maxLines,
        minLines: minLines,
        inputFormatters: !isSpaceAllowed
            ? [
                LengthLimitingTextInputFormatter(30),
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ]
            : [LengthLimitingTextInputFormatter(30)],
        onChanged: onChanged,
        textAlign: TextAlign.start,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          isCollapsed: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          filled: true,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
