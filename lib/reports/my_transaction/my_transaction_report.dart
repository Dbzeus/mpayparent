import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utils/constant_function.dart';
import '../../utils/constant_string.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/filter_header.dart';
import 'my_transaction_controller.dart';

class MyTransactionReportScreen extends GetView<MyTransactionReportController> {
  final controller = Get.put(MyTransactionReportController());

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

  MyTransactionReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Transaction",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Obx(
              () => FilterHeader(
                onFilterTap: (String fromDate, String toDate) {
                  controller.getTransactionReport(fromDate, toDate);
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
            Obx(() => controller.reportData.isEmpty
                ? const Center(
                    child: Text("No Records found",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: 2, //controller.reportData.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (__, index) =>
                            _showMyTransferReport()), /*controller.reportData[index]*/
                  )),
          ],
        ),
      ),
    );
  }

  _showMyTransferReport(/*transactionReportData*/) {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
                    /*onLongPress: () async {
                      await Clipboard.setData(ClipboardData(
                          text: transactionReportData.clientRefID));
                      toast('copied');
                    },*/
                    child: Text(
                      "Ref No: ", //${transactionReportData.clientRefID}",
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
                Text('$rs 1000', //${transactionReportData.amount}',
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
                  child: Text(
                      "Transaction ID: ", //${transactionReportData.transactionID}",
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
                Row(
                  children: [
                    /*Icon(
                      transactionReportData.status
                              .toLowerCase()
                              .contains('success')
                          ? Icons.verified
                          : transactionReportData.status
                                  .toLowerCase()
                                  .contains('failure')
                              ? Icons.close_sharp
                              : Icons.refresh,
                      size: 14,
                      color: transactionReportData.status
                              .toLowerCase()
                              .contains('success')
                          ? Colors.green
                          : transactionReportData.status
                                  .toLowerCase()
                                  .contains('failure')
                              ? Colors.red
                              : secondaryColor,
                    ),*/
                    const SizedBox(
                      width: 4,
                    ),
                    /*Text("Status ", //transactionReportData.status,
                        style: TextStyle(
                          fontSize: 13,
                          color: transactionReportData.status
                                  .toLowerCase()
                                  .contains('success')
                              ? Colors.green
                              : transactionReportData.status
                                      .toLowerCase()
                                      .contains('failure')
                                  ? Colors.red
                                  : secondaryColor,
                          fontWeight: FontWeight.bold,
                        )),*/
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text("Sender: ", //${transactionReportData.senderName}",
                style: const TextStyle(
                  fontSize: 12,
                )),
            const SizedBox(
              height: 8,
            ),
            Text("Description: ", //${transactionReportData.senderName}",
                style: const TextStyle(
                  fontSize: 12,
                )),
            const SizedBox(
              height: 8,
            ),
            Text("Account number",
                //"${transactionReportData.accountNumber} - ${transactionReportData.bankName}",
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
                    Text(
                        "1000", //transactionReportData.openingBalance.toString(),
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
                    Text("1000",
                        //transactionReportData.transferCommissionCharge
                        //  .toString(),
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
                    Text(
                        "1000", //transactionReportData.retailerCommission.toString(),
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
                    Text(
                        "1000", //transactionReportData.closingBalance.toString(),
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
              child: Text("Date", //transactionReportData.transactionDate,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
