import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mpayparent/model/retailerDetailsResponse.dart';
import 'package:mpayparent/utils/session.dart';

import '../../../../api/api_call.dart';
import '../../../../utils/constant_function.dart';
import '../../../../utils/constant_string.dart';
import '../../../parent/model/userList.dart';

class UserDetailsController extends GetxController {
  TextEditingController searchController = TextEditingController();
  int userId = -1;
  int roleId = -1;
  final _box = GetStorage();
  RxString title = "".obs;
  RxList<UserListReturnData> userList = RxList();
  RxList<RetailerResponseReturnData> distributorList = RxList();
  List<UserListReturnData> tempList = [];
  List<RetailerResponseReturnData> tempListDI = [];

  RxBool isLoading = false.obs;

  void onInit() {
    roleId = Get.arguments["roleId"];
    title(Get.arguments["title"]);
    super.onInit();
    userId = _box.read(Session.userId);
    if (roleId.isEqual(distributorRoleId)) {
      getDistributorDetails();
    } else {
      getUserDetails();
    }
  }

  getDistributorDetails() async {
    if (await isNetConnected()) {
      isLoading(true);
      RetailerDetailsResponse? distributorDetailsResponse =
          await ApiCall().getRetailerDistributor("0", roleId.toString(), "1");
      if (distributorDetailsResponse != null &&
          distributorDetailsResponse.status) {
        if (distributorDetailsResponse.returnData.isNotEmpty) {
          distributorList(distributorDetailsResponse.returnData);
          tempListDI = distributorDetailsResponse.returnData;
        }
        isLoading(false);
      }
    }
  }

  getUserDetails() async {
    if (await isNetConnected()) {
      isLoading(true);
      UserList? userDetailsResponse =
          await ApiCall().getUserDetailsByRole("0", roleId.toString(), "1");
      if (userDetailsResponse != null && userDetailsResponse.status) {
        if (userDetailsResponse.returnData.isNotEmpty) {
          userList(userDetailsResponse.returnData);
          tempList = userDetailsResponse.returnData;
        }
      }
      isLoading(false);
    }
  }

  onSearchChanged(String text) {
    if (text.isEmpty) {
      userList(tempList);
    } else {
      userList(tempList
          .where((element) =>
              element.firstName.toLowerCase().contains(text.toLowerCase()) ||
              element.mobileNo.contains(text.toLowerCase()))
          .toList());
    }
  }

  onSearchChangedDI(String text) {
    if (text.isEmpty) {
      distributorList(tempListDI);
    } else {
      distributorList(tempListDI
          .where((element) =>
              element.firstName.toLowerCase().contains(text.toLowerCase()) ||
              element.mobileNo.contains(text.toLowerCase()))
          .toList());
    }
  }
}
