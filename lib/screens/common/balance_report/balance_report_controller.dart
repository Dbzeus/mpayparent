import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mpayparent/model/balance_report_response.dart';
import 'package:mpayparent/utils/session.dart';

import '../../../api/api_call.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/constant_function.dart';

class BalanceReportController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<BalanceReportResponseData> searchList = [];
  RxList<BalanceReportResponseData> balanceList = RxList();
  RxString totalBalance = "-1".obs;
  RxString title = "-1".obs;
  int roleId = -1;
  bool isAll = false;
  int userId = -1;
  final _box = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userId = _box.read(Session.userId);
    balanceList(Get.arguments["response"]);
    searchList = Get.arguments["response"];
    title(Get.arguments["TITLE"]);
    roleId = Get.arguments["ROLEID"];
    isAll = Get.arguments["ISALL"];
  }

  getBalance() async {
    if (await isNetConnected()) {
      BalanceReportResponse? retailerBalanceResponse = await ApiCall().getBalance(
          isAll ? 0 : userId,
          roleId); //Retailer id = 6 is constant,its used for show total retailers balance,is fixed
      if (retailerBalanceResponse != null && retailerBalanceResponse.status) {
        if (retailerBalanceResponse.returnData.isNotEmpty) {
          totalBalance(retailerBalanceResponse.message);
          balanceList(retailerBalanceResponse.returnData);
          //Not included the AEPS Amount
        }
      }
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      balanceList(searchList);
    } else {
      balanceList(searchList
          .where((element) =>
              element.firstName
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.mobileNo
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.amount
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
          .toList());
    }
  }
}
