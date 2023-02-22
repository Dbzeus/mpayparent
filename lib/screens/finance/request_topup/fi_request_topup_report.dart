import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/distributorRequestResponse.dart';
import 'package:mpayparent/routes/app_routes.dart';
import 'package:mpayparent/utils/custom_colors.dart';

import '../../../../utils/constant_string.dart';
import '../../../../widgets/filter_header.dart';
import '../../../utils/constant_function.dart';
import '../../../utils/constant_widgets.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_edittext.dart';
import 'fi_request_topup_report_controller.dart';

class FIRequestTopupReportScreen
    extends GetView<FIRequestTopupReportController> {
  @override
  final controller = Get.put(FIRequestTopupReportController());
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

  FIRequestTopupReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Topup"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            Obx(
              () => FilterHeader(
                onFilterTap: (String fromDate, String toDate) {
                  controller.getRequestTopupReport(fromDate, toDate);
                },
                onSearchChanged: (text) {
                  controller.onSearchChanged(text);
                },
                isLoading: controller.isLoading.value,
              ),
            ),
            Obx(
              () => controller.reportList.isEmpty
                  ? Expanded(
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
                              _showRequestTopupTransferReport(
                                  controller.reportList[index])),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _showRequestTopupTransferReport(
      DistributorRequestResponseReturnData reportData) {
    return GestureDetector(
      onTap: () async {
        var mpin = await showMpinDialog();
        if (mpin != null && mpin == controller.mmpin) {
          _topupRetailer(reportData);
        } else {
          toast("Invalid MPin");
        }
      },
      child: Container(
        decoration: boxDecoration,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(reportData.reqName,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.green,
                  ),
                  child: Text("$rs ${reportData.reqAmt.toString()}",
                      style: const TextStyle(
                          fontSize: 14,
                          color: textColor,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            Text(reportData.remarks,
                style: const TextStyle(
                  fontSize: 14,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reportData.proofImage.isEmpty
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.showImage, arguments: {
                            "ImageUrl": reportData.proofImage.toString()
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text("Attachment",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor)),
                        ),
                      ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(reportData.reqDate,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _topupRetailer(DistributorRequestResponseReturnData reportData) async {
    var amountController =
        TextEditingController(text: reportData.reqAmt.toString());
    var remarkController = TextEditingController();
    return Get.bottomSheet(
        isScrollControlled: true,
        GestureDetector(
          onTap: () {
            Get.focusScope!.unfocus();
          },
          child: Container(
            height: Get.height * 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: EdgeInsets.only(top: Get.statusBarHeight + 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                      "${reportData.reqName} is requested ${rs} ${reportData.reqAmt}",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const Divider(),
                CustomEditText(
                  contentPadding: const EdgeInsets.only(left: 12),
                  controller: amountController,
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
                        controller: remarkController,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                        width: Get.width / 2.5,
                        buttonColor: secondaryColor,
                        text: "Cancel",
                        onTap: () {
                          Get.back();
                        }),
                    Obx(
                      () => CustomButton(
                        width: Get.width / 2.5,
                        isLoading: controller.isLoading.value,
                        text: "Save",
                        onTap: () {
                          if (amountController.text.isNotEmpty &&
                              int.parse(amountController.text.toString()) > 0) {
                            controller.retailerTopup(
                                reportData.topupReqID.toString(),
                                amountController.text.toString(),
                                remarkController.text.toString());
                          } else {
                            toast('Enter Valid Amount');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
