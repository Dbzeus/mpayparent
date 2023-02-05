import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/custom_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_edittext.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  final controller = Get.put(LoginController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/icon/mpayy.png',
                  width: 250,
                  height: 130,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text("Login \nto Account",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(
                height: 12,
              ),
              const Text(
                  "Login with Mobile Number and \nMPIN to use your Account",
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryTextColor,
                  )),
              const SizedBox(
                height: 24,
              ),
              CustomEditText(
                  contentPadding: const EdgeInsets.only(left: 14),
                  controller: controller.mobileNoController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  isOnlyInt: true,
                  hintText: "Mobile Number"),
              const SizedBox(
                height: 12,
              ),
              CustomEditText(
                  contentPadding: const EdgeInsets.only(left: 14),
                  controller: controller.mpinController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  obsecureText: true,
                  fontSize: 20,
                  isOnlyInt: true,
                  hintText: "MPIN"),
              const SizedBox(
                height: 24,
              ),
              Obx(
                () => CustomButton(
                  text: "Login",
                  isLoading: controller.isLoading.value,
                  onTap: () => controller.logIn(),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Obx(() =>
                  Center(child: Text('App Version ${controller.appVersion}'))),
            ],
          ),
        ),
      ),
    );
  }
}
