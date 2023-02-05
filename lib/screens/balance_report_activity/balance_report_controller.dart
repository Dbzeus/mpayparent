import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/balance_report_response.dart';

class BalanceReportController extends GetxController {
  TextEditingController searchController = TextEditingController();

  List<BalanceReportResponseData> searchList = [];
  RxList<BalanceReportResponseData> retailerList = RxList();
  RxString totalBalance = Get.arguments["balance"];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    retailerList(Get.arguments["response"]);
    searchList = retailerList;
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      retailerList(searchList);
      debugPrint("REtailer: ${retailerList.toString()}");
      debugPrint("search: ${searchList.toString()}");
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
