import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mpayparent/model/retailerDetailsResponse.dart';
import 'package:mpayparent/utils/session.dart';

import '../../../api/api_call.dart';
import '../../../utils/constant_function.dart';
import '../../../utils/constant_string.dart';

class DIRetailerDetailsController extends GetxController {
  TextEditingController searchController = TextEditingController();
  int userId = -1;
  final _box = GetStorage();

  RxList<RetailerResponseReturnData> retailerDetails = RxList();
  List<RetailerResponseReturnData> temp = [];
  RxBool isLoading=false.obs;

  void onInit() {
    super.onInit();
    userId = _box.read(Session.userId);
    getRetailerDetails();
  }

  getRetailerDetails() async {
    if (await isNetConnected()) {
      isLoading(true);
      RetailerDetailsResponse? retailerDetailsResponse = await ApiCall()
          .getRetailerDistributor(userId.toString(), retailerRoleId.toString(),
              "1"); //Retailer id = 6 is constant,its used for show total retailers balance,is fixed
      if (retailerDetailsResponse != null && retailerDetailsResponse.status) {
        if (retailerDetailsResponse.returnData.isNotEmpty) {
          retailerDetails(retailerDetailsResponse.returnData);
          temp = retailerDetailsResponse.returnData;
          //Not included the AEPS Amount
        }
      }
      isLoading(false);
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      retailerDetails(temp);
    } else {
      retailerDetails(temp
          .where((element) =>
              element.firstName.toLowerCase().contains(text.toLowerCase()) ||
              element.mobileNo.contains(text.toLowerCase()))
          .toList());
    }
  }
}
