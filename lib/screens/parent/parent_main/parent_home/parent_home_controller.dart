import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:mpayparent/model/parentDashboardResponse.dart';
import 'package:mpayparent/routes/app_routes.dart';
import 'package:mpayparent/utils/session.dart';

import '../../../../api/api_call.dart';
import '../../../../utils/constant_function.dart';
import '../../../../utils/constant_string.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_edittext.dart';

class ParentHomeController extends GetxController {
  RxList<ParentDashboardResponseReturnData> parentDashboard = RxList();
  final _box = GetStorage();
  int userId = -1;
  int roleId = -1;
  RxString bankItValue = "-1".obs,
      parentValue = "-1".obs,
      distributorValue = "-1".obs,
      retailerValue = "-1".obs,
      financierValue = "-1".obs,
      paySprint = "-1".obs;
  RxString ourCommision = "-1".obs,
      distCommision = "-1".obs,
      retailerCommision = "-1".obs;

  TextEditingController refnoController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    bankItValue(_box.read(Session.bankItBalance) ?? "0");
    distributorValue(_box.read(Session.distributorBalance) ?? "0");
    retailerValue(_box.read(Session.retailerBalance) ?? "0");
    parentValue(_box.read(Session.parentBalance) ?? "0");
    financierValue(_box.read(Session.financierBalance) ?? "0");
    paySprint(_box.read(Session.paySprintBalance) ?? "0");
    ourCommision(_box.read(Session.ourCommision) ?? "0");
    distCommision(_box.read(Session.distributorCommision) ?? "0");
    retailerCommision(_box.read(Session.retailerCommision) ?? "0");
    userId = _box.read(Session.userId);
    roleId = _box.read(Session.roleId);
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
          bankItValue(parentDashboard[0].bcb);
          distributorValue(parentDashboard[0].dcb);
          retailerValue(parentDashboard[0].rcb);
          parentValue(parentDashboard[0].pcb);
          financierValue(parentDashboard[0].fcb);
          paySprint(parentDashboard[0].paysprint);
          ourCommision(parentDashboard[0].pc);
          distCommision(parentDashboard[0].dc);
          retailerCommision(parentDashboard[0].rc);
          _box.write(Session.bankItBalance, parentDashboard[0].bcb);
          _box.write(Session.distributorBalance, parentDashboard[0].dcb);
          _box.write(Session.retailerBalance, parentDashboard[0].rcb);
          _box.write(Session.parentBalance, parentDashboard[0].pcb);
          _box.write(Session.financierBalance, parentDashboard[0].fcb);
          _box.write(Session.paySprintBalance, parentDashboard[0].paysprint);
          _box.write(Session.ourCommision, parentDashboard[0].pc);
          _box.write(Session.distributorCommision, parentDashboard[0].dc);
          _box.write(Session.retailerCommision, parentDashboard[0].rc);
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

  /*getRefNumber() async {
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
  }*/

  showDistributorList() {
    Get.toNamed(AppRoutes.balanceReportActivityScreen, arguments: {
      "ISALL": true,
      "ROLEID": distributorRoleId,
      "TITLE": "Distributor Balance"
    });
  }

  showRetailerList() {
    Get.toNamed(AppRoutes.balanceReportActivityScreen, arguments: {
      "ISALL": true,
      "ROLEID": retailerRoleId,
      "TITLE": "Retailer Balance"
    });
  }

  showFinancierList() {
    Get.toNamed(AppRoutes.balanceReportActivityScreen, arguments: {
      "ISALL": true,
      "ROLEID": financeRoleId,
      "TITLE": "Financier Balance"
    });
  }
}
