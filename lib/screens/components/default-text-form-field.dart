import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hope_clinic/theme/style.dart';
import 'package:hope_clinic/utils/color.dart';

class DefaultTextFormField extends StatelessWidget {
  final Function onChanged;
  final Widget prefixIcon;
  final String hintText;
  final int maxLength;
  TextCapitalization textCapitalization;
  final  List<TextInputFormatter> inputFormatters;
  final TextInputType keyboardType;
  final FocusNode focus, nextFocus;
  final TextInputAction textInputAction;
  final Widget suffixIcon;
  final bool obscureText, disabled;
  final String initialValue;
  final String fillColorCode;
  final Function(String) validator;
  final TextEditingController controller;
  final VoidCallback onTap;
  final String textColor;

  DefaultTextFormField({
    this.textColor = '#A6A6A6',
    this.onChanged,
    this.maxLength,
    this.textCapitalization,
    this.prefixIcon,
    this.inputFormatters,
    this.keyboardType,
    this.focus,
    this.nextFocus,
    this.disabled = false,
    this.textInputAction,
    this.validator,
    this.fillColorCode = '#F4F4F4',
    this.onTap,
    this.suffixIcon,
    this.initialValue,
    this.obscureText = false,
    this.controller,
    @required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextFormField(
        controller: controller,
        onChanged: this.onChanged,
        textCapitalization: textCapitalization!=
            null?textCapitalization:TextCapitalization.none,
        inputFormatters: inputFormatters,
        onTap: onTap,
        initialValue: initialValue,
        textAlignVertical: TextAlignVertical.bottom,
        enabled: !disabled,
        validator: validator,
        style: inputTextStyle.copyWith(fontSize: 15),
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: HexColor(fillColorCode),
          contentPadding: EdgeInsets.all(18.0),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: HexColor('#F4F4F4'),
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: HexColor('#F4F4F4'),
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: HexColor("#DEE2FC"),
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          hintText: this.hintText,
          prefixIcon: this.prefixIcon,
          prefixStyle: subheadingTextStyle.copyWith(fontSize: 15.0),
          hintStyle: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            color: HexColor(textColor),
          ),
        ),
        focusNode: this.focus,
        obscureText: obscureText,
        textInputAction: this.textInputAction != null
            ? this.textInputAction
            : TextInputAction.done,
        onFieldSubmitted: (v) {
          if (this.nextFocus != null) {
            FocusScope.of(context).requestFocus(this.nextFocus);
          }
        },
        keyboardType:
        this.keyboardType != null ?
        this.keyboardType
            : TextInputType.text,
      ),
    );
  }
}
