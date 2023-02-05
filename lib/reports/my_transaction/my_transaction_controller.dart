import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../api/api_call.dart';
import '../../utils/constant_function.dart';
import '../../utils/session.dart';

class MyTransactionReportController extends GetxController {
  final _box = GetStorage();
  RxBool isLoading = false.obs;
  RxList reportData = RxList();
  List searchList = [];
  DateTime today = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    getTransactionReport(
        DateFormat('MM/dd/yyyy').format(DateTime(today.year, today.month, 1)),
        DateFormat('MM/dd/yyyy').format(today));
  }

  getTransactionReport(String startDate, String endDate) async {
    if (startDate.isEmpty && endDate.isEmpty) {
      toast("Select From & To Dates");
    } else {
      isLoading(true);
      final reportResponse = await ApiCall()
          .getMyTranactionReport(_box.read(Session.userId), startDate, endDate);
      isLoading(false);
      if (reportResponse != null && reportResponse["Status"]) {
        reportData(reportResponse["ReturnData"]);
        //searchList = reportResponse.reportData;
      } else {
        toast(reportResponse["Message"]);
      }
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      reportData(searchList);
    } else {
      reportData(searchList
          .where((element) =>
              element.reqName
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.remarks
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.requestStatus
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
          .toList());
    }
  }
}
