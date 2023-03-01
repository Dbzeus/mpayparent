import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mpayparent/model/myTransactionResponse.dart';

import '../../../api/api_call.dart';
import '../../../utils/constant_function.dart';
import '../../../utils/session.dart';

class DIMyTransactionReportController extends GetxController {
  final _box = GetStorage();
  RxBool isLoading = false.obs;
  RxList<MyTransactionResponseReturnData> reportData = RxList();
  List<MyTransactionResponseReturnData> searchList = [];
  DateTime today = DateTime.now();

  @override
  void onInit() {
    super.onInit();
    getTransactionReport(
        DateFormat('dd/MM/yyyy').format(DateTime(today.year, today.month, 1)),
        DateFormat('dd/MM/yyyy').format(today));
  }

  getTransactionReport(String startDate, String endDate) async {
    if (startDate.isEmpty && endDate.isEmpty) {
      toast("Select From & To Dates");
    } else {
      isLoading(true);
      MyTransactionResponse? reportResponse = await ApiCall()
          .getMyTranactionReport(_box.read(Session.userId), startDate, endDate);
      isLoading(false);
      if (reportResponse != null && reportResponse.status) {
        reportData(reportResponse.returnData);
        searchList = reportResponse.returnData;
        //searchList = reportResponse.reportData;
      } else {
        toast(reportResponse?.message);
      }
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      reportData(searchList);
    } else {
      reportData(searchList
          .where((element) =>
              element.description
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.userName
                  .toString()
                  .toLowerCase()
                  .contains(text.toLowerCase()))
          .toList());
    }
  }
}
