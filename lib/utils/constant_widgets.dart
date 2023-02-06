import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';

import '../widgets/custom_edittext.dart';
import 'constant_function.dart';
import 'custom_colors.dart';

Future showMpinDialog({
  bool isDismissable = true,
  bool isForgetEnable = false,
  Function()? forgotClicked,
}) async {
  final mpinController = TextEditingController();
  return await Get.dialog(
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(12),
          height: Get.height * 0.22,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter MPIN',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              const Divider(),
              CustomEditText(
                controller: mpinController,
                hintText: 'MPIN',
                maxLength: 4,
                isOnlyInt: true,
                keyboardType: TextInputType.number,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                    width: 100,
                    height: 35,
                    onTap: () {
                      if (mpinController.text.length == 4) {
                        Get.back(result: int.parse(mpinController.text));
                      } else {
                        toast('Enter Valid MPIN');
                      }
                    },
                    text: 'Validate'),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: isDismissable);

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
