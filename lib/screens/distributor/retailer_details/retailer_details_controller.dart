import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mpayparent/model/retailerDetailsResponse.dart';
import 'package:mpayparent/model/user_login_response.dart';
import 'package:mpayparent/utils/session.dart';

import '../../../api/api_call.dart';
import '../../../utils/constant_function.dart';
import '../../../utils/constant_string.dart';

class RetailerDetailsController extends GetxController {
  TextEditingController searchController = TextEditingController();
  int userId = -1;
  final _box = GetStorage();

  RxList<RetailerResponseReturnData> retailerDetails = RxList();

  void onInit() {
    userId = (_box.read(Session.userId));
    super.onInit();
    getRetailerDetails();
  }

  getRetailerDetails() async {
    if (await isNetConnected()) {
      RetailerDetailsResponse? retailerDetailsResponse = await ApiCall()
          .getRetailerDistributor(userId.toString(), retailerRoleId.toString(),
              "1"); //Retailer id = 6 is constant,its used for show total retailers balance,is fixed
      if (retailerDetailsResponse != null && retailerDetailsResponse.status) {
        if (retailerDetailsResponse.returnData.isNotEmpty) {
          retailerDetails(retailerDetailsResponse.returnData);
          //Not included the AEPS Amount
        }
      }
    }
  }
}
