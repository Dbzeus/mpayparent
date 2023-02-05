import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/custom_colors.dart';

// ignore: must_be_immutable
class CustomEditText extends StatelessWidget {
  String? placeholder, hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  EdgeInsets? contentPadding;
  int? maxLines, maxLength, minLines;
  bool readOnly, obsecureText;
  TextEditingController? controller;
  Color? borderColor, textColor;
  Function(String)? onChanged, onSubmitted;
  VoidCallback? onTab;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  double? width, height, fontSize, cursorHeight, cursorWidth;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  bool isMaxNull, showCursor, showBorder, isEnabled, isOnlyInt, isUpperCase;

  CustomEditText({
    Key? key,
    this.placeholder,
    this.showBorder = true,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.fontSize,
    this.readOnly = false,
    this.obsecureText = false,
    this.isEnabled = true,
    this.isOnlyInt = false,
    this.isUpperCase = false,
    this.borderColor,
    this.textColor,
    this.onChanged,
    this.onSubmitted,
    this.onTab,
    this.textInputAction,
    this.keyboardType,
    this.textAlign,
    this.width,
    this.height,
    this.cursorHeight,
    this.fontWeight,
    this.cursorWidth,
    this.isMaxNull = false,
    this.showCursor = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height ?? 50,
      width: width ?? Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onTap: onTab,
        onChanged: onChanged,
        maxLength: maxLength,
        readOnly: readOnly,
        controller: controller,
        textAlign: textAlign ?? TextAlign.start,
        cursorHeight: cursorHeight,
        cursorWidth: cursorWidth ?? 2,
        showCursor: showCursor,
        maxLines: maxLines ?? 1,
        minLines: minLines,
        obscureText: obsecureText,
        enabled: isEnabled,
        inputFormatters: isOnlyInt
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
        textCapitalization: isUpperCase
            ? TextCapitalization.characters
            : TextCapitalization.none,
        style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: fontSize,
            color: textColor,
            fontWeight: fontWeight),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          counter: null,
          labelText: placeholder,
          counterText: '',
          hintText: hintText,
          contentPadding:
              contentPadding ?? const EdgeInsets.symmetric(horizontal: 12),
          focusedBorder: showBorder
              ? OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: secondaryButtonColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                )
              : null,
          border: showBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              : InputBorder.none,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
