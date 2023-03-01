import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/balance_report_response.dart';
import 'package:mpayparent/utils/custom_colors.dart';
import 'package:mpayparent/widgets/custom_edittext.dart';

import '../../../utils/constant_string.dart';
import 'balance_report_controller.dart';

class BalanceReportScreen extends GetView<BalanceReportController> {
  @override
  final controller = Get.put(BalanceReportController());

  var boxDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          spreadRadius: 1,
          blurRadius: 1,
          color: Color.fromRGBO(237, 237, 237, 1),
        )
      ]);

  BalanceReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value)),
      ),
      body: GestureDetector(
        onTap: () {
          Get.focusScope!.unfocus();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: CustomEditText(
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
            ),
            Container(
              height: 50,
              width: Get.width,
              color: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total Balance",
                      style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                      )),
                  Obx(
                    () => Text("$rs ${controller.totalBalance.value}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.balanceList.isEmpty
                        ? const Center(
                            child: Text("No Records found",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                          )
                        : ListView.builder(
                            itemCount: controller.balanceList.length,
                            padding: const EdgeInsets.all(8),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (__, index) =>
                                _showRetailerBalanceReport(
                                    controller.balanceList[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showRetailerBalanceReport(BalanceReportResponseData response) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: boxDecoration,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(response.firstName,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                Text(response.mobileNo.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    )),
              ],
            ),
            Text("$rs ${response.amount}",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
