import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../api/api_call.dart';
import '../../../model/retailerTopupHistoryResponse.dart';
import '../../../utils/constant_function.dart';
import '../../../utils/session.dart';

class PATopupActivityController extends GetxController {
  final _box = GetStorage();
  RxBool isLoading = false.obs;
  int tType = -1;
  RxString title = "-1".obs;
  RxList<TopupHistoryResponseReturnData> reportList = RxList();
  List<TopupHistoryResponseReturnData> searchList = [];
  DateTime today = DateTime.now();

  @override
  void onInit() {
    title(Get.arguments["title"]);
    tType = Get.arguments["tType"];
    super.onInit();
    getTopupReport(
        DateFormat('MM/dd/yyyy').format(DateTime(today.year, today.month, 1)),
        DateFormat('MM/dd/yyyy').format(DateTime.now()));
  }

  getTopupReport(String fromDate, String toDate) async {
    if (fromDate.isEmpty && toDate.isEmpty) {
      toast("Select From & To Dates");
    } else {
      if (await isNetConnected()) {
        isLoading(true);

        TopupHistoryResponse? reportResponse = await ApiCall()
            .getTopupHistoryReport(
                _box.read(Session.userId), tType, fromDate, toDate);
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
