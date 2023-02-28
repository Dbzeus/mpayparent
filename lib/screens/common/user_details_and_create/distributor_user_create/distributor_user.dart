import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/utils/custom_colors.dart';
import 'package:mpayparent/widgets/custom_button.dart';
import 'package:mpayparent/widgets/custom_edittext.dart';

import '../../../../utils/constant_string.dart';
import 'distributor_user_controller.dart';

class DistributorCreateScreen extends GetView<DistributorCreateController> {
  @override
  final controller = Get.put(DistributorCreateController());

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

  DistributorCreateScreen({Key? key}) : super(key: key);

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
                            GestureDetector(
                              onTap: () async {
                                var image = await controller.pickImage();
                                controller.profileImage(image);
                              },
                              child: Obx(
                                () => Container(
                                  height: Get.height * 0.14,
                                  width: Get.width / 4.3,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                      image: controller.profileImage.isEmpty
                                          ? const DecorationImage(
                                              image: AssetImage(
                                              'assets/icon/profile.png',
                                            ))
                                          : DecorationImage(
                                              fit: BoxFit.fill,
                                              image: FileImage(File(controller
                                                  .profileImage.value)))),
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
                  Container(
                    decoration: boxDecoration,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
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
                        CustomEditText(
                          controller: controller.organisationNameController,
                          hintText: "Organisation name",
                          contentPadding: const EdgeInsets.only(left: 12),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomEditText(
                          controller: controller.addressController,
                          hintText: "Address",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: boxDecoration,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        CustomEditText(
                          controller: controller.gstController,
                          hintText: "GST NO",
                          contentPadding: const EdgeInsets.only(left: 12),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var image = await controller.pickImage();
                                    controller.bankAgreementFront(image);
                                  },
                                  child: Obx(
                                    () => Container(
                                        height: Get.height * 0.12,
                                        width: Get.width * 0.37,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: secondaryColor),
                                            image: DecorationImage(
                                                image: FileImage(File(controller
                                                    .bankAgreementFront
                                                    .value)))),
                                        child: controller.bankAgreementFront
                                                .value.isEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.add,
                                                    size: 35,
                                                  ),
                                                  Text("Add")
                                                ],
                                              )
                                            : const SizedBox.shrink()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Bank Agreement Front",
                                  maxLines: 2,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var image = await controller.pickImage();
                                    controller.bankAgreementBack(image);
                                  },
                                  child: Obx(
                                    () => Container(
                                        height: Get.height * 0.12,
                                        width: Get.width * 0.37,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: secondaryColor),
                                            image: DecorationImage(
                                                image: FileImage(File(controller
                                                    .bankAgreementBack
                                                    .value)))),
                                        child: controller
                                                .bankAgreementBack.isEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.add,
                                                    size: 35,
                                                  ),
                                                  Text(
                                                    "Add",
                                                  )
                                                ],
                                              )
                                            : const SizedBox.shrink()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Bank Agreement Back",
                                  maxLines: 2,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: boxDecoration,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        CustomEditText(
                          controller: controller.aadharController,
                          hintText: "Aadhar Number",
                          maxLength: 12,
                          contentPadding: const EdgeInsets.only(left: 12),
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Obx(
                                  () => GestureDetector(
                                    onTap: () async {
                                      var image = await controller.pickImage();
                                      controller.aadharFront(image);
                                    },
                                    child: Container(
                                        height: Get.height * 0.12,
                                        width: Get.width * 0.37,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: secondaryColor),
                                            image: DecorationImage(
                                                image: FileImage(File(controller
                                                    .aadharFront.value)))),
                                        child: controller.aadharFront.isEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.add,
                                                    size: 35,
                                                  ),
                                                  Text("Add")
                                                ],
                                              )
                                            : const SizedBox.shrink()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Aadhar Front",
                                  maxLines: 2,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var image = await controller.pickImage();
                                    controller.aadharBack(image);
                                  },
                                  child: Obx(
                                    () => Container(
                                        height: Get.height * 0.12,
                                        width: Get.width * 0.37,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: secondaryColor),
                                            image: DecorationImage(
                                                image: FileImage(File(controller
                                                    .aadharBack.value)))),
                                        child: controller.aadharBack.isEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.add,
                                                    size: 35,
                                                  ),
                                                  Text(
                                                    "Add",
                                                  )
                                                ],
                                              )
                                            : const SizedBox.shrink()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "Aadhar Back",
                                  maxLines: 2,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: boxDecoration,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        CustomEditText(
                          controller: controller.panController,
                          hintText: "PAN Number",
                          contentPadding: const EdgeInsets.only(left: 12),
                          maxLines: 1,
                          isUpperCase: true,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                var image = await controller.pickImage();
                                controller.panFront(image);
                              },
                              child: Obx(
                                () => Container(
                                    height: Get.height * 0.14,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border:
                                            Border.all(color: secondaryColor),
                                        image: DecorationImage(
                                            image: FileImage(File(
                                                controller.panFront.value)))),
                                    child: controller.panFront.isEmpty
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.add,
                                                size: 35,
                                              ),
                                              Text("Add")
                                            ],
                                          )
                                        : const SizedBox.shrink()),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "PAN Front",
                              maxLines: 2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    decoration: boxDecoration,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        CustomEditText(
                          controller: controller.aepsController,
                          hintText: "AEPS ID",
                          contentPadding: const EdgeInsets.only(left: 12),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var image = await controller.pickImage();
                                    controller.mpayAgreementFront(image);
                                  },
                                  child: Obx(
                                    () => Container(
                                        height: Get.height * 0.12,
                                        width: Get.width * 0.37,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: secondaryColor),
                                            image: DecorationImage(
                                                image: FileImage(File(controller
                                                    .mpayAgreementFront
                                                    .value)))),
                                        child: controller
                                                .mpayAgreementFront.isEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.add,
                                                    size: 35,
                                                  ),
                                                  Text("Add")
                                                ],
                                              )
                                            : const SizedBox.shrink()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "MPAY Agreement Front",
                                  maxLines: 2,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    var image = await controller.pickImage();
                                    controller.mpayAgreementBack(image);
                                  },
                                  child: Obx(
                                    () => Container(
                                        height: Get.height * 0.12,
                                        width: Get.width * 0.37,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: secondaryColor),
                                            image: DecorationImage(
                                                image: FileImage(File(controller
                                                    .mpayAgreementBack
                                                    .value)))),
                                        child: controller
                                                .mpayAgreementBack.isEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Icon(
                                                    Icons.add,
                                                    size: 35,
                                                  ),
                                                  Text(
                                                    "Add",
                                                  )
                                                ],
                                              )
                                            : const SizedBox.shrink()),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  "MPAY Agreement Back",
                                  maxLines: 2,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  controller.userData == null
                      ? Container(
                          decoration: boxDecoration,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Shop Image",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var image = await controller.pickImage();
                                  controller.shopImage(image);
                                },
                                child: Obx(
                                  () => Container(
                                      height: Get.height * 0.17,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border:
                                              Border.all(color: secondaryColor),
                                          image: DecorationImage(
                                              image: FileImage(File(controller
                                                  .shopImage.value)))),
                                      child: controller.shopImage.isEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.add,
                                                  size: 35,
                                                ),
                                                Text("Add")
                                              ],
                                            )
                                          : const SizedBox.shrink()),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
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
