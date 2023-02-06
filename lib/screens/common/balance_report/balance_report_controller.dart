import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/balance_report_response.dart';

class BalanceReportController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<BalanceReportResponseData> searchList = [];
  RxList<BalanceReportResponseData> retailerList = RxList();
  RxString totalBalance = Get.arguments["balance"];
  RxString title = Get.arguments["title"] ?? "Balance Report";
  RxString role = Get.arguments["role"];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    retailerList(Get.arguments["response"]);
    searchList = Get.arguments["response"];
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      retailerList(searchList);
    } else {
      retailerList(searchList
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
