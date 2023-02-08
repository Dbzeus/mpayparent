import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mpayparent/api/api_call.dart';
import 'package:mpayparent/model/distributorRequestResponse.dart';

import '../../../../utils/constant_function.dart';
import '../../../../utils/session.dart';
import '../../../utils/constant_string.dart';
import '../../../utils/constant_widgets.dart';

class RequestTopupController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  final _box = GetStorage();
  RxBool isLoading = false.obs;
  int mmpin = -1;
  int userId = -1;
  RxList<DistributorRequestResponseReturnData> reportList = RxList();
  List<DistributorRequestResponseReturnData> searchList = [];
  DateTime today = DateTime.now();

  @override
  void onInit() {
    mmpin = _box.read(Session.userMpin); //need otp validation.
    userId = _box.read(Session.userId); //need otp validation.
    super.onInit();
    getRequestTopupReport(
        DateFormat('MM/dd/yyyy').format(DateTime(today.year, today.month, 1)),
        DateFormat('MM/dd/yyyy').format(today));
  }

  getRequestTopupReport(String fromDate, String toDate) async {
    if (fromDate.isEmpty && toDate.isEmpty) {
      toast("Select From & To Dates");
    } else {
      if (await isNetConnected()) {
        isLoading(true);
        DistributorRequestResponse? reportResponse = await ApiCall()
            .getDistributorRequestReport(
                0, _box.read(Session.userId), 1, fromDate, toDate);

        if (reportResponse != null && reportResponse.status) {
          reportList(reportResponse.returnData);
          searchList = reportResponse.returnData;
        }
        isLoading(false);
      }
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      reportList(searchList);
    } else {
      reportList(searchList
          .where((element) =>
              element.bankName
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.reqAmt
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
          .toList());
    }
  }

  retailerTopup(DistributorRequestResponseReturnData reportData) async {
    isLoading(true);
    var params = {
      "TransType": 3,
      "TransFrom": userId,
      "TransTo": reportData.topupReqID,
      "UserID": userId,
      "Amount": amountController.text,
      "Remarks": remarkController.text.toString(),
    };
    final topupResponse =
        await ApiCall().retailerDistributorRequestedTopup(params);
    if (topupResponse != null) {
      toast("Amount added successfully");
      debugPrint("Payment success");
    }
    isLoading(false);
    Get.back();
  }
}
