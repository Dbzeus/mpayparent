import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/utils/constant_string.dart';
import 'package:mpayparent/utils/custom_colors.dart';
import 'package:mpayparent/widgets/custom_button.dart';
import 'package:mpayparent/widgets/custom_edittext.dart';

import 'topup_controller.dart';

class TopupScreen extends GetView<TopupController> {
  @override
  final controller = Get.put(TopupController());

  TopupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(controller.title.value),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            Get.focusScope!.unfocus();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    controller.isParent
                        ? const SizedBox.shrink()
                        : CustomEditText(
                            width: Get.width,
                            readOnly: true,
                            showBorder: true,
                            showCursor: false,
                            controller: controller.payeeController,
                            hintText: controller.payeeTitle.value,
                            suffixIcon: const Icon(
                              Icons.arrow_drop_down,
                              size: 25,
                            ),
                            onTab: () async {
                              _showPayeeList();
                            },
                          ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomEditText(
                      width: Get.width,
                      contentPadding: const EdgeInsets.only(left: 12),
                      controller: controller.amountController,
                      maxLength: 10,
                      showBorder: true,
                      hintText: "Amount",
                      isOnlyInt: true,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomEditText(
                            controller: controller.remarkController,
                            hintText: "Remarks",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            maxLines: 5,
                          ),
                        ),
                        controller.isParent || controller.isFinance
                            ? Obx(
                                () => Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: CustomButton(
                                    width: Get.width * 0.25,
                                    height: 90,
                                    borderRadius: 8,
                                    onTap: () => controller.attachImage(),
                                    buttonColor: Colors.grey.shade100,
                                    widget: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.attach_file,
                                          size: 30,
                                          color: controller.isAttached.value
                                              ? secondaryColor
                                              : null,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            controller.isAttached.value
                                                ? "Attached"
                                                : "Attach",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: controller.isAttached.value
                                                  ? secondaryColor
                                                  : null,
                                            )),
                                      ],
                                    ),
                                    text: '',
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
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
                              controller.topup();
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
      ),
    );
  }

  _showPayeeList() {
    return Get.bottomSheet(
      isScrollControlled: true,
      GestureDetector(
        onTap: () {
          Get.focusScope!.unfocus();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: EdgeInsets.only(top: Get.statusBarHeight + 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Obx(
                  () => Text("Select ${controller.payeeTitle} ",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomEditText(
                controller: controller.searchController,
                hintText: "Search",
                maxLines: 1,
                onChanged: (text) {
                  controller.onSearchChangedDistributor(text);
                },
                suffixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                child: controller.userList.isEmpty
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('User Not Found'),
                      ))
                    : ListView.builder(
                        itemCount: controller.userList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (__, index) {
                          return ListTile(
                            dense: true,
                            isThreeLine: false,
                            leading: const Icon(
                              Icons.person,
                              size: 24,
                              color: secondaryButtonColor,
                            ),
                            onTap: () {
                              controller.payeeController.text =
                                  controller.userList[index]["name"].toString();
                              controller.payeeId =
                                  controller.userList[index]["id"];
                              controller.searchController.clear();
                              Get.back();
                            },
                            title: Text(
                                "${controller.userList[index]["name"]} (${controller.userList[index]["no"]})",
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                )),
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
