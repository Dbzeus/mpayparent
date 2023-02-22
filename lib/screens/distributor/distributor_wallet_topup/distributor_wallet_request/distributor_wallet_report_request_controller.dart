import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mpayparent/api/api_call.dart';
import 'package:mpayparent/model/distributorRequestResponse.dart';

import '../../../../utils/constant_function.dart';
import '../../../../utils/session.dart';

class DIWalletRequestController extends GetxController {
  final _box = GetStorage();
  RxBool isLoading = false.obs;
  RxList<DistributorRequestResponseReturnData> reportList = RxList();
  List<DistributorRequestResponseReturnData> searchList = [];
  DateTime today = DateTime.now();

  var fdate, tdate;

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
        fdate = fromDate;
        tdate = toDate;
        isLoading(true);
        DistributorRequestResponse? reportResponse = await ApiCall()
            .getDistributorRequestReport(
                _box.read(Session.userId), 0, 0, fromDate, toDate);

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
}
