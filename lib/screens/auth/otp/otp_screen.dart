import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant_function.dart';
import '../../../utils/custom_colors.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_edittext.dart';
import 'otp_controller.dart';

class OtpScreen extends GetView<OtpController> {
  @override
  final controller = Get.put(OtpController());

  OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'BACK',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            color: Colors.black, onPressed: () => Get.back(),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/icon/otp.png',
                  )),
              const SizedBox(
                height: 12,
              ),
              const Text("OTP\nVerify!",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 12,
              ),
              const Text("Enter 6-digit code we have sent to at",
                  style: TextStyle(
                    fontSize: 14,
                  )),
              Text("+91  ${maskedOutput(controller.data.mobileno)}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: secondaryTextColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  )),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _customOTPField(
                      first: true,
                      last: false,
                      controller: controller.fieldOne),
                  const SizedBox(
                    width: 12,
                  ),
                  _customOTPField(
                      first: false,
                      last: false,
                      controller: controller.fieldTwo),
                  const SizedBox(
                    width: 12,
                  ),
                  _customOTPField(
                      first: false,
                      last: false,
                      controller: controller.fieldThree),
                  const SizedBox(
                    width: 12,
                  ),
                  _customOTPField(
                      first: false,
                      last: false,
                      controller: controller.fieldFour),
                  const SizedBox(
                    width: 12,
                  ),
                  _customOTPField(
                      first: false,
                      last: false,
                      controller: controller.fieldFive),
                  const SizedBox(
                    width: 12,
                  ),
                  _customOTPField(
                      first: false,
                      last: true,
                      controller: controller.fieldSix),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Obx(
                () => controller.isResend.value
                    ? Row(
                        children: [
                          const Text("Did not get code?   ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                          GestureDetector(
                            onTap: () {
                              controller.resendOTP();
                            },
                            child: const Text(
                              'Resend',
                              style: TextStyle(
                                  color: secondaryTextColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  fontSize: 14),
                            ),
                          )
                        ],
                      )
                    : Obx(() => controller.seconds.value > 0
                        ? Text(
                            "This session will end in ${controller.seconds.value} seconds",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ))
                        : const SizedBox.shrink()),
              ),
              const SizedBox(
                height: 80,
              ),
              Obx(
                () => CustomButton(
                  text: "Verify OTP",
                  shadow: true,
                  isLoading: controller.isLoading.value,
                  onTap: () => controller.verifyOTP(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _customOTPField({bool? first, last, TextEditingController? controller}) {
    return Expanded(
      child: CustomEditText(
        controller: controller,
        hintText: '',
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        showCursor: false,
        onChanged: (value) {
          if (value.length == 1 && last == false) {
            Get.focusScope?.nextFocus();
          }
          if (value.isEmpty && first == false) {
            Get.focusScope?.previousFocus();
          }
        },
      ),
    );
  }
}
