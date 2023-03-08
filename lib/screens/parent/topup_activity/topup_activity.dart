import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/retailerTopupHistoryResponse.dart';
import 'package:mpayparent/routes/app_routes.dart';
import 'package:mpayparent/screens/parent/topup_activity/topup_activity_controller.dart';
import 'package:mpayparent/widgets/filter_header.dart';

import '../../../utils/constant_string.dart';

class PATopupActivityScreen extends GetView<PATopupActivityController> {
  PATopupActivityScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(PATopupActivityController());

  var boxDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          spreadRadius: 1,
          blurRadius: 1,
          color: Color.fromRGBO(237, 237, 237, 1),
        )
      ]);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Text(
              controller.title.value,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              Obx(
                () => FilterHeader(
                  onFilterTap: (String fromDate, String toDate) {
                    controller.getTopupReport(fromDate, toDate);
                  },
                  onSearchChanged: (text) {
                    controller.onSearchChanged(text);
                  },
                  isLoading: controller.isLoading.value,
                ),
              ),
              const SizedBox(
                height: 10,
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
                        child: Obx(
                        () => ListView.builder(
                          itemCount: 2, //controller.reportList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (__, index) =>
                              _showTopupReport(controller.reportList[index]),
                        ),
                      )),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.topupScreen,
                arguments: {"tType": controller.tType});
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _showTopupReport(TopupHistoryResponseReturnData reportData) {
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
                    reportData.description,
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
                Text("$rs ${reportData.transValue.toString()}",
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
                Text(reportData.transactionDate,
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
                        "Balance: $rs ${reportData.closingBalanceTrTo.toString()}",
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
