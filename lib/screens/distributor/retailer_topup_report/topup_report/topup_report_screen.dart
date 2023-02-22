import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/retailerTopupHistoryResponse.dart';
import 'package:mpayparent/routes/app_routes.dart';

import '../../../../utils/constant_string.dart';
import '../../../../widgets/filter_header.dart';
import 'topup_report_controller.dart';

class DITopupReportScreen extends GetView<DITopupReportController> {
  final controller = Get.put(DITopupReportController());
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

  DITopupReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Distributor"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              Obx(
                () => FilterHeader(
                  onFilterTap: (String fromDate, String toDate) {
                    controller.getDistributorRequestReport(fromDate, toDate);
                  },
                  onSearchChanged: (text) {
                    controller.onSearchChanged(text);
                  },
                  isLoading: controller.isLoading.value,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => controller.reportList.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text("No Records found",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: controller.reportList.length,
                            //controller.reportData.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (__, index) => _showTopupHistoryReport(
                                controller.reportList[index])),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.distributorRetailerTopupScreen);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _showTopupHistoryReport(TopupHistoryResponseReturnData reportList) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: boxDecoration,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    reportList.description,
                    style: const TextStyle(
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text("$rs ${reportList.transValue.toString()}",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reportList.transactionDate,
                    style: const TextStyle(
                      fontSize: 14,
                    )),
                Row(
                  children: [
                    const Icon(
                      Icons.verified,
                      color: Colors.green,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                        "Balance: $rs ${reportList.closingBalanceTrTo.toString()}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
