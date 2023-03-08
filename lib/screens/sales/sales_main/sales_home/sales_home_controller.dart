import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:mpayparent/model/balance_report_response.dart';
import 'package:mpayparent/model/parentDashboardResponse.dart';
import 'package:mpayparent/routes/app_routes.dart';
import 'package:mpayparent/utils/session.dart';

import '../../../../api/api_call.dart';
import '../../../../utils/constant_function.dart';
import '../../../../utils/constant_string.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_edittext.dart';

class SalesHomeController extends GetxController {
  RxList<ParentDashboardResponseReturnData> parentDashboard = RxList();
  RxString retailerTotalBalance = "-1".obs;
  RxString distributorTotalBalance = "-1".obs;
  final _box = GetStorage();
  int userId = -1;
  int roleId = -1;
  RxString profileImage = "".obs;

  TextEditingController refnoController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    retailerTotalBalance(_box.read(Session.retailerBalance) ?? "0");
    distributorTotalBalance(_box.read(Session.distributorBalance) ?? "0");
    userId = _box.read(Session.userId);
    roleId = _box.read(Session.roleId);
    profileImage(_box.read(Session.profileImage));
    super.onInit();
    checkDevice(userId);
    getDashboardBalance();
  }

  getDashboardBalance() async {
    if (await isNetConnected()) {
      ParentDashboardResponse? response =
          await ApiCall().parentDashboard(); //give
      if (response != null && response.status) {
        if (response.returnData.isNotEmpty) {
          parentDashboard(response.returnData);
          distributorTotalBalance(parentDashboard[0].dcb);
          retailerTotalBalance(parentDashboard[0].rcb);
          _box.write(Session.distributorBalance, parentDashboard[0].dcb);
          _box.write(Session.retailerBalance, parentDashboard[0].rcb);
          //Not included the AEPS Amount
        }
      }
    }
  }

  showRetailersList() async {
    Get.toNamed(AppRoutes.balanceReportActivityScreen, arguments: {
      "ISALL": true,
      "ROLEID": retailerRoleId,
      "TITLE": "Retailer Balance"
    });
  }

  onRefresh() async {
    await getDashboardBalance();
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
    }
  }

  showDistributorList() {
    Get.toNamed(AppRoutes.balanceReportActivityScreen, arguments: {
      "ISALL": true,
      "ROLEID": distributorRoleId,
      "TITLE": "Distributor Balance"
    });
  }
}
