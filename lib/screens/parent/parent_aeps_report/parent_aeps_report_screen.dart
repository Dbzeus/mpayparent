import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mpayparent/screens/parent/parent_aeps_report/parent_aeps_report_controller.dart';

import 'package:mpayparent/utils/custom_colors.dart';
import 'package:mpayparent/widgets/filter_header.dart';

import '../../../model/dmt_report_response.dart';
import '../../../utils/constant_function.dart';
import '../../../utils/constant_string.dart';

class PAAepsReportScreen extends GetView<PAAepsReportController> {
  PAAepsReportScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(PAAepsReportController());

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
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            "AEPS Report",
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
                  controller.getDmtReport(fromDate, toDate);
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
              () => controller.reportData.isEmpty
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
                        itemCount: controller.reportData.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (__, index) => _showDmtTransferReport(
                            controller.reportData[index]),
                      ),
                    )),
            ),
          ],
        ),
      ),
    );
  }

  _showDmtTransferReport(DmtReportData dmtReportData) {
    return Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onLongPress: () async {
                    await Clipboard.setData(
                        ClipboardData(text: dmtReportData.clientRefID));
                    toast('copied');
                  },
                  child: Text(
                    "Ref No: ${dmtReportData.clientRefID}",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text('$rs ${dmtReportData.amount}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text("Transaction ID: ${dmtReportData.transactionID}",
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
              Row(
                children: [
                  Icon(
                    dmtReportData.status.toLowerCase().contains('success')
                        ? Icons.verified
                        : dmtReportData.status.toLowerCase().contains('failure')
                            ? Icons.close_sharp
                            : Icons.refresh,
                    size: 14,
                    color: dmtReportData.status
                            .toLowerCase()
                            .contains('success')
                        ? Colors.green
                        : dmtReportData.status.toLowerCase().contains('failure')
                            ? Colors.red
                            : secondaryColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(dmtReportData.status,
                      style: TextStyle(
                        fontSize: 13,
                        color: dmtReportData.status
                                .toLowerCase()
                                .contains('success')
                            ? Colors.green
                            : dmtReportData.status
                                    .toLowerCase()
                                    .contains('failure')
                                ? Colors.red
                                : secondaryColor,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text("Sender: ${dmtReportData.senderName}",
              style: const TextStyle(
                fontSize: 12,
              )),
          const SizedBox(
            height: 8,
          ),
          Text("${dmtReportData.accountNumber} - ${dmtReportData.bankName}",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text("Opening",
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  Text(dmtReportData.openingBalance.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              Column(
                children: [
                  const Text("Charges",
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  Text(dmtReportData.transferCommissionCharge.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              Column(
                children: [
                  const Text("Commission",
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  Text(dmtReportData.retailerCommission.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              Column(
                children: [
                  const Text("Closing",
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  Text(dmtReportData.closingBalance.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(dmtReportData.transactionDate,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
    );
  }
}
