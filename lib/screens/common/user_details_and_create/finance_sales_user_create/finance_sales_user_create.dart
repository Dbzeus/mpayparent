import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/utils/custom_colors.dart';
import 'package:mpayparent/widgets/custom_button.dart';
import 'package:mpayparent/widgets/custom_edittext.dart';

import '../../../../utils/constant_string.dart';
import 'finance_sales_user_create_controller.dart';

class FinanceSalesCreateScreen extends GetView<FinanceSalesCreateController> {
  @override
  final controller = Get.put(FinanceSalesCreateController());

  var boxDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          spreadRadius: 2,
          blurRadius: 2,
          color: Color.fromRGBO(237, 237, 237, 1),
        )
      ]);

  FinanceSalesCreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(controller.title.value),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: boxDecoration,
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  var image = controller.pickImage();
                                  controller.imagePath(image);
                                },
                                child: Container(
                                  height: Get.height * 0.14,
                                  width: Get.width * 0.23,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryColor,
                                      image: controller.imagePath.isEmpty
                                          ? const DecorationImage(
                                              image: AssetImage(
                                              'assets/icon/profile.png',
                                            ))
                                          : controller.userData?.profileImage
                                                      .isEmpty ??
                                                  false
                                              ? DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: FileImage(File(
                                                      controller
                                                          .imagePath.value)))
                                              : DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(controller
                                                          .imagePath
                                                          .value //need to decode
                                                      ))),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomEditText(
                                  width: Get.width * 0.6,
                                  contentPadding:
                                      const EdgeInsets.only(left: 12),
                                  controller: controller.firstNameController,
                                  maxLines: 1,
                                  showBorder: true,
                                  hintText: "First Name",
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                CustomEditText(
                                  width: Get.width * 0.6,
                                  contentPadding:
                                      const EdgeInsets.only(left: 12),
                                  controller: controller.lastNameController,
                                  showBorder: true,
                                  hintText: "Last Name",
                                  maxLines: 1,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomEditText(
                    width: Get.width,
                    contentPadding: const EdgeInsets.only(left: 12),
                    controller: controller.mobileNoController,
                    maxLength: 10,
                    showBorder: true,
                    hintText: "Mobile Number",
                    isOnlyInt: true,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomEditText(
                    controller: controller.mailController,
                    hintText: "Email Id",
                    keyboardType: TextInputType.emailAddress,
                    contentPadding: const EdgeInsets.only(left: 12),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  controller.roleId == saleRoleId
                      ? CustomEditText(
                          controller: controller.zoneController,
                          hintText: "Zone",
                          contentPadding: const EdgeInsets.only(left: 12),
                          maxLines: 1,
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: controller.roleId == saleRoleId ? 12 : 0,
                  ),
                  CustomEditText(
                    controller: controller.remarksController,
                    hintText: "Remarks",
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    maxLines: 5,
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                          width: Get.width / 2.5,
                          buttonColor: secondaryColor,
                          text: "Cancel",
                          onTap: controller.isLoading.value
                              ? () {}
                              : () {
                                  Get.back();
                                }),
                      Obx(
                        () => CustomButton(
                          width: Get.width / 2.5,
                          isLoading: controller.isLoading.value,
                          text: "Save",
                          onTap: () {
                            controller.insertUser();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
