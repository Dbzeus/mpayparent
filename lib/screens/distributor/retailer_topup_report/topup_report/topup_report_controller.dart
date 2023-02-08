import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mpayparent/model/retailerTopupHistoryResponse.dart';
import 'package:mpayparent/utils/constant_function.dart';

import '../../../../api/api_call.dart';
import '../../../../utils/session.dart';

class TopupReportController extends GetxController {
  final _box = GetStorage();
  RxBool isLoading = false.obs;
  RxList<RetailerTopupHistoryResponseReturnData> reportList = RxList();
  List<RetailerTopupHistoryResponseReturnData> searchList = [];
  DateTime today = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    getDistributorRequestReport(
        DateFormat('MM/dd/yyyy').format(DateTime(today.year, today.month, 1)),
        DateFormat('MM/dd/yyyy').format(today));
  }

  getDistributorRequestReport(String fromDate, String toDate) async {
    if (fromDate.isEmpty && toDate.isEmpty) {
      toast("Select From & To Dates");
    } else {
      if (await isNetConnected()) {
        isLoading(true);

        RetailerTopupHistoryResponse? reportResponse = await ApiCall()
            .getRetailerTopupHistoryReport(
                _box.read(Session.userId), 6, fromDate, toDate);
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
              element.transFromName
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.transToName
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.transValue
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
          .toList());
    }
  }
}
