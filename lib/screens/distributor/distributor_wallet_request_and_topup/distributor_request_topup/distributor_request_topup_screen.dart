import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/utils/custom_colors.dart';
import 'package:mpayparent/widgets/custom_button.dart';

import '../../../../widgets/custom_edittext.dart';
import 'distributor_request_topup_controller.dart';

class DIRequestTopupScreen extends GetView<DIRequestTopupController> {
  @override
  final controller = Get.put(DIRequestTopupController());

  DIRequestTopupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Distributor Request Top up",
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
                  readOnly: true,
                  showBorder: true,
                  showCursor: false,
                  controller: controller.bankController,
                  hintText: "Select Bank",
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    size: 25,
                  ),
                  onTab: () async {
                    _showBankList(controller.bankList);
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
                    const SizedBox(
                      width: 12,
                    ),
                    Obx(
                      () => CustomButton(
                        width: Get.width * 0.25,
                        height: 90,
                        borderRadius: 8,
                        onTap: () => controller.attachImage(),
                        buttonColor: Colors.grey.shade100,
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          controller.dmtWalletTopup();
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

  _showBankList(RxList bankList) {
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
              child: Text("Select Bank",
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
                controller.onSearchChanged(text);
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
                child: bankList.isEmpty
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Bank Not Found'),
                      ))
                    : ListView.builder(
                        itemCount: bankList.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (__, index) {
                          return ListTile(
                            dense: true,
                            isThreeLine: false,
                            leading: const Icon(
                              Icons.account_balance_outlined,
                              size: 24,
                              color: secondaryButtonColor,
                            ),
                            onTap: () {
                              controller.bankController.text =
                                  bankList[index]["BankName"].toString();
                              controller.bankId = bankList[index]["BankID"];
                              debugPrint("Bank id" +
                                  bankList[index]["BankID"].toString());
                              controller.searchController.clear();
                              Get.back();
                            },
                            title: Text(bankList[index]["BankName"].toString(),
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
