import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mpayparent/api/api_call.dart';

import '../../../model/dmt_report_response.dart';
import '../../../utils/constant_function.dart';
import '../../../utils/session.dart';

class PAAepsReportController extends GetxController {
  final _box = GetStorage();
  RxBool isLoading = false.obs;
  RxList<DmtReportData> reportData = RxList();

  bool isParent = false;
  RxString title = "".obs;
  List<DmtReportData> tempList = [];
  DateTime today = DateTime.now();

  @override
  void onInit() {
    isParent = Get.arguments["isParent"];
    title(Get.arguments["title"]);
    super.onInit();
    getDmtReport(
        DateFormat('MM/dd/yyyy').format(DateTime(today.year, today.month, 1)),
        DateFormat('MM/dd/yyyy').format(DateTime.now()));
  }

  getDmtReport(String fromDate, String toDate) async {
    if (fromDate.isEmpty && toDate.isEmpty) {
      toast("Select From & To Dates");
    } else {
      if (await isNetConnected()) {
        isLoading(true);
        DmtReport? reportResponse = await ApiCall().getDmtReport(
            isParent ? 0 : _box.read(Session.userId), fromDate, toDate);
        isLoading(false);

        if (reportResponse != null && reportResponse.status) {
          reportData(reportResponse.dmtData);
          tempList = reportResponse.dmtData;
        }
      }
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      reportData(tempList);
    } else {
      reportData(tempList
          .where((element) =>
              element.senderName
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.amount
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.accountNumber
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.transactionID
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
          .toList());
    }
  }
}
