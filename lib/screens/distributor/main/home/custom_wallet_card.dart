import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/custom_colors.dart';

class CustomWalletCard extends StatelessWidget {
  CustomWalletCard({Key? key}) : super(key: key);

  final List<Color> gradient = [
    primaryColor,
    primaryColor,
    Colors.white,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: Get.width,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          stops: const [0.0, 50, 50, 1.0],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
        ),
      ),
    );
  }
}
