import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/distributorRequestResponse.dart';
import 'package:mpayparent/utils/constant_string.dart';

import '../../../../routes/app_routes.dart';
import '../../../../widgets/filter_header.dart';
import 'distributor_wallet_report_request_controller.dart';

class DIWalletRequestScreen extends GetView<DIWalletRequestController> {
  @override
  final controller = Get.put(DIWalletRequestController());
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

  DIWalletRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Wallet Request"),
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
                        child: ListView.builder(
                            itemCount: controller.reportList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (__, index) =>
                                _showTopupTransferReport(
                                    controller.reportList[index])),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var res =
                await Get.toNamed(AppRoutes.distributorRequestTopUpScreen);
            if (res != null && res) {
              controller.getDistributorRequestReport(
                  controller.fdate, controller.tdate);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _showTopupTransferReport(DistributorRequestResponseReturnData reportData) {
    return Container(
      decoration: boxDecoration,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRow(
                "Bank Name",
              ),
              _buildRow(reportData.bankName, weightedFont: true)
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRow(
                "Request Date",
              ),
              _buildRow(reportData.reqDate, weightedFont: true)
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRow(
                "Request Amount",
              ),
              _buildRow("$rs ${reportData.reqAmt}", weightedFont: true)
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRow(
                "Remarks",
              ),
              _buildRow(reportData.remarks, weightedFont: true)
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRow(
                "Status",
              ),
              _buildRow(reportData.requestStatus, weightedFont: true)
            ],
          ),
        ],
      ),
    );
  }

  _buildRow(String text, {bool weightedFont = false}) {
    return Expanded(
      child: Text(text,
          maxLines: 1,
          style: TextStyle(
              fontSize: 13, fontWeight: weightedFont ? FontWeight.w700 : null)),
    );
  }
}
