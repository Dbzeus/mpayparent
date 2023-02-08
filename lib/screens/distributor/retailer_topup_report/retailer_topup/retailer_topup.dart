import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/utils/custom_colors.dart';
import 'package:mpayparent/widgets/custom_button.dart';
import 'package:mpayparent/widgets/custom_edittext.dart';

import 'retailer_topup_controller.dart';

class RetailerTopupScreen extends GetView<RetailerTopupController> {
  @override
  final controller = Get.put(RetailerTopupController());

  RetailerTopupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Retailer Top up",
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomEditText(
                  width: Get.width,
                  readOnly: true,
                  showBorder: true,
                  showCursor: false,
                  controller: controller.retailerController,
                  hintText: "Select Retailer",
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    size: 25,
                  ),
                  onTab: () async {
                    _showRetailerList();
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
                          controller.retailerTopup();
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
    );
  }

  _showRetailerList() {
    return Get.bottomSheet(
      isScrollControlled: true,
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.only(top: Get.statusBarHeight + 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text("Select Retailer",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomEditText(
              controller: controller.searchController,
              hintText: "Search",
              maxLines: 1,
              onChanged: (text) {
                ///controller.onSearchChanged(text);
              },
              suffixIcon: const Icon(
                Icons.search,
                size: 20,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
                  () => Expanded(
                child: controller.retailerList.isEmpty
                    ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Retailer Not Found'),
                    ))
                    : ListView.builder(
                    itemCount: controller.retailerList.length,
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
                          controller.retailerController.text = controller
                              .retailerList[index].firstName
                              .toString();
                          controller.retailerId =
                              controller.retailerList[index].userID;
                          controller.searchController.clear();
                          Get.back();
                        },
                        title: Text(
                            "${controller.retailerList[index].firstName} (${controller.retailerList[index].mobileNo})",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            )),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
