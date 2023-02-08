import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:mpayparent/model/balance_report_response.dart';
import 'package:mpayparent/routes/app_routes.dart';
import 'package:mpayparent/utils/session.dart';

import '../../../../api/api_call.dart';
import '../../../../utils/constant_function.dart';
import '../../../../utils/constant_string.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_edittext.dart';

class DistributorHomeController extends GetxController {
  RxString distributorCurrentBalance = "-1".obs;
  RxString retailerTotalBalance = "-1".obs;
  final _box = GetStorage();
  int userId = -1;
  int roleId = -1;

  TextEditingController refnoController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    distributorCurrentBalance(
        _box.read(Session.distributorCurrentBalance) ?? "0");
    retailerTotalBalance(_box.read(Session.retailerTotalBalance) ?? "0");
    userId = _box.read(Session.userId);
    roleId = _box.read(Session.roleId);
    super.onInit();
    checkDevice(userId);
    getDistributorWalletBalance();
    getRetailerWalletBalance();
  }

  getDistributorWalletBalance() async {
    if (await isNetConnected()) {
      var distributorBalanceResponse =
          await ApiCall().getCurrentBalance(userId); //give
      if (distributorBalanceResponse != null &&
          distributorBalanceResponse["Status"]) {
        if (distributorBalanceResponse["ReturnData"].isNotEmpty) {
          distributorCurrentBalance(
              distributorBalanceResponse["ReturnData"][0]["Amount"].toString());
          _box.write(Session.distributorCurrentBalance,
              distributorCurrentBalance.value);
          //Not included the AEPS Amount
        }
      }
    }
  }

  getRetailerWalletBalance() async {
    if (await isNetConnected()) {
      BalanceReportResponse? retailerBalanceResponse = await ApiCall().getBalance(
          userId,
          retailerRoleId); //Retailer id = 6 is constant,its used for show total retailers balance
      if (retailerBalanceResponse != null && retailerBalanceResponse.status) {
        if (retailerBalanceResponse.returnData.isNotEmpty) {
          retailerTotalBalance(retailerBalanceResponse.message);
          _box.write(Session.retailerTotalBalance, retailerTotalBalance.value);
          //Not included the AEPS Amount
        }
      }
    }
  }

  showRetailersList() async {
    Get.toNamed(AppRoutes.balanceReportActivityScreen, arguments: {
      "ISALL": false,
      "ROLEID": retailerRoleId,
      "TITLE": "Retailer Balance"
    });
  }

  onRefresh() async {
    await getDistributorWalletBalance();
    await getRetailerWalletBalance();
  }

  getRefNumber() async {
    if (await isNetConnected()) {
      refnoController.clear();
      String? refNo = await Get.bottomSheet(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          Container(
            padding: const EdgeInsets.all(16),
            height: Get.height / 3.3,
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                const Text("Enter Reference Number",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 24,
                ),
                CustomEditText(
                  controller: refnoController,
                  hintText: 'Reference Number',
                  isOnlyInt: true,
                  keyboardType: TextInputType.number,
                ),
                const Spacer(),
                CustomButton(
                    onTap: () => Get.back(result: refnoController.text.trim()),
                    text: 'Check Status'),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ));
      /*if (refNo != null) {
        isLoading(true);
        var response = await ApiCall().dmtTransactionStatus(refNo);
        isLoading(false);
        if (response != null) {
          if (response['status']) {
            Get.bottomSheet(Container(
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: response['response_code'] == 1
                      ? successColors
                      : failedColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Lottie.asset(
                        response['response_code'] == 1
                            ? 'assets/lottie/success.json'
                            : 'assets/lottie/failed.json',
                        height: 100),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(response['response_code'] == 1 ? 'Success' : 'Failed',
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Account Number",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(response['account'],
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      thickness: 1,
                      endIndent: 40,
                      indent: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text("Reference No #$refNo",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white)),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Transferred Amount",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    Text('$rs ${response['amount']}',
                        style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ],
                )));
          } else {
            toast(response['message']);
          }
        }
      }*/
    }
  }
}
