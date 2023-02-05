import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_keyboard.dart';
import 'custom_colors.dart';

Future showMpinBottomSheet({
  bool isDismissable = false,
  bool isForgetEnable = false,
  Function()? forgotClicked,
}) async {
  RxString keyValue = ''.obs;
  return await Get.bottomSheet(
      backgroundColor: Colors.white,
      enableDrag: isDismissable,
      isDismissible: isDismissable,
      Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.back(result: 'back');
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.topRight,
                child: Text("Cancel",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Enter Your MPIN",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 25,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                  4,
                  (index) => Container(
                        margin: const EdgeInsets.all(12),
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                            color: keyValue.value.length > index
                                ? secondaryButtonColor
                                : Colors.grey,
                            shape: BoxShape.circle),
                      )),
            ),
          ),
          const Spacer(),
          CustomKeyboard(onChange: (String text) {
            //pass the changing value to RxString
            keyValue(text);
          }, onDone: (String text) {
            //when mpin is done check
            Get.back(result: int.parse(keyValue.value));
          }),
          const SizedBox(
            height: 10,
          ),
          isForgetEnable
              ? Expanded(
                  child: InkWell(
                    onTap: () {
                      forgotClicked!();
                      Get.back(result: 'forgot');
                    },
                    child: const Text("Forget MPIN? ",
                        style: TextStyle(
                          fontSize: 12,
                          color: secondaryTextColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ));
}

Future showCustomAlertDialog({
  required String title, //required title
  required String content, //required content

  String? cancel,
  String? confirm,
  Function()? onTabCancel,
  Function()? onTabConfirm,
  bool isDismissable = true,
}) async {
  return await Get.defaultDialog(
    radius: 14,
    barrierDismissible: isDismissable,
    onWillPop: () async => isDismissable,
    contentPadding: const EdgeInsets.all(8),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          cancel == null
              ? SizedBox(
                  width: Get.width * 0.3,
                )
              : CustomButton(
                  height: 35,
                  width: Get.width * 0.3,
                  shadow: true,
                  borderRadius: 8,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  btnTextColor: textColor,
                  buttonColor: secondaryButtonColor,
                  text: cancel,
                  onTap: () {
                    Get.back();
                    onTabCancel!();
                  },
                ),
          confirm == null
              ? SizedBox(
                  width: Get.width * 0.3,
                )
              : CustomButton(
                  height: 35,
                  width: Get.width * 0.3,
                  shadow: true,
                  borderRadius: 8,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  btnTextColor: textColor,
                  buttonColor: primaryButtonColor,
                  text: confirm,
                  onTap: () {
                    Get.back();
                    onTabConfirm!();
                  },
                ),
        ],
      )
    ],
    buttonColor: primaryButtonColor,
    title: title,
    content: Text(
      content,
      style: const TextStyle(
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    ),
    titleStyle: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}
