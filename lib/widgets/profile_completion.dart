/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/custom_colors.dart';

class ProfileCompletion extends StatelessWidget {
  const ProfileCompletion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: Get.height / 4,
        width: Get.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Complete Profile",
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryTextColor,
                      fontWeight: FontWeight.bold,
                    )),
                Text("7 out of 10 complete",
                    style: TextStyle(
                      fontSize: 10,
                      color: textLightColor,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Icon(
                  Icons.person,
                  size: 28,
                  color: secondaryButtonColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Personal information",
                    style: TextStyle(
                      fontSize: 18,
                      color: primaryTextColor,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                "When you register for an account we collect information",
                style: TextStyle(
                  fontSize: 14,
                  color: textLightColor,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
*/
