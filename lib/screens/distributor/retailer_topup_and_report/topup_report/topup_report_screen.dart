import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/retailerTopupHistoryResponse.dart';
import 'package:mpayparent/routes/app_routes.dart';

import '../../../../utils/constant_string.dart';
import '../../../../widgets/filter_header.dart';
import 'topup_report_controller.dart';

class TopupReportScreen extends GetView<TopupReportController> {
  final controller = Get.put(TopupReportController());
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
  TopupReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Topup"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            FilterHeader(
              onFilterTap: (String fromDate, String toDate) {
                //controller.getTransactionReport(fromDate, toDate);
              },
              onSearchChanged: (text) {
                //controller.onSearchChanged(text);
              },
              //isLoading: controller.isLoading.value,
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.reportList.isEmpty
                  ? const Center(
                      child: Text("No Records found",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    )
                  : Expanded(
                      child: ListView.builder(
                          itemCount: controller.reportList
                              .length, //controller.reportData.length,
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
          Get.toNamed(AppRoutes.retailerTopupScreen);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _showTopupHistoryReport(RetailerTopupHistoryResponseReturnData reportList) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.only(bottom: 6),
      decoration: boxDecoration,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${reportList.transFromName} To ${reportList.transToName}",
                        style: const TextStyle(
                            fontSize: 14, overflow: TextOverflow.ellipsis)),
                    Text("$rs ${reportList.transValue.toString()}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            Text("Balance: $rs ${reportList.closingBalanceTrTo}",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reportList.transactionDate,
                    style: const TextStyle(
                      fontSize: 14,
                    )),
                const Icon(
                  Icons.verified,
                  color: Colors.green,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
