import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/custom_colors.dart';

class CustomButton extends StatelessWidget {
  double? height, width;
  double borderRadius, fontSize;
  bool shadow;
  Color buttonColor, btnTextColor;
  String text;
  Function() onTap;
  EdgeInsets? margin;
  Widget? widget;
  bool isLoading;

  CustomButton({
    Key? key,
    this.height,
    required this.onTap,
    this.width,
    this.widget,
    this.fontSize = 15,
    this.borderRadius = 8,
    this.margin,
    this.btnTextColor = textColor,
    this.buttonColor = primaryButtonColor,
    required this.text,
    this.shadow = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            width: width ?? Get.width,
            height: height ?? 50,
            child: const Center(child: CircularProgressIndicator()))
        : GestureDetector(
            onTap: onTap,
            child: Container(
                height: height ?? 50,
                width: width ?? Get.width,
                margin: margin,
                decoration: BoxDecoration(
                    boxShadow: shadow
                        ? [
                            const BoxShadow(
                              offset: Offset(0, 5),
                              color: Colors.black54,
                              blurRadius: 5,
                            )
                          ]
                        : null,
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: buttonColor),
                child: widget ??
                    Center(
                        child: Text(
                      text,
                      style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w700,
                          color: btnTextColor),
                    ))),
          );
  }
}
