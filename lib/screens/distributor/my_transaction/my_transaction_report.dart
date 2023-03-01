import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/myTransactionResponse.dart';

import '../../../utils/constant_string.dart';
import '../../../widgets/filter_header.dart';
import 'my_transaction_controller.dart';

class DIMyTransactionReportScreen
    extends GetView<DIMyTransactionReportController> {
  @override
  final controller = Get.put(DIMyTransactionReportController());

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

  DIMyTransactionReportScreen({Key? key}) : super(key: key);

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
        child: GestureDetector(
          onTap: () {
            Get.focusScope!.unfocus();
          },
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
                          itemCount: controller.reportData.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (__, index) => _showMyTransferReport(
                              controller.reportData[index])),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  _showMyTransferReport(MyTransactionResponseReturnData reportData) {
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
            Text(
                "Description: ${reportData.description.isNotEmpty ? reportData.description : '-'}",
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                )),
            const SizedBox(
              height: 8,
            ),
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
                    Text(reportData.openingBalance.toString(),
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
                    Text(reportData.charges.toString(),
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
                    Text(reportData.commission.toString(),
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
                    Text(reportData.closingBalance.toString(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reportData.transactionDate,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    )),
                Text('$rs ${reportData.transValue}',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ],
            ),
            /* Align(
              alignment: Alignment.bottomRight,
              child: Text(reportData.transactionDate,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
            ),*/
          ],
        ),
      ),
    );
  }
}
