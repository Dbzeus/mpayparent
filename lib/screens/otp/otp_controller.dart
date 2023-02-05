import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../api/api_call.dart';
import '../../model/user_login_response.dart';
import '../../routes/app_routes.dart';
import '../../utils/constant_function.dart';
import '../../utils/session.dart';

class OtpController extends GetxController {
  TextEditingController fieldOne = TextEditingController();
  TextEditingController fieldTwo = TextEditingController();
  TextEditingController fieldThree = TextEditingController();
  TextEditingController fieldFour = TextEditingController();
  TextEditingController fieldFive = TextEditingController();
  TextEditingController fieldSix = TextEditingController();

  final _box = GetStorage();
  RxBool isLoading = false.obs;

  Timer? timer;
  RxInt seconds = 30.obs;
  RxBool isResend = false.obs;

  UserData data = Get.arguments["userData"];
  String otp = "";

  @override
  void onInit() {
    super.onInit();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds.value > 0) {
        seconds--;
        if (seconds.value == 0) {
          isResend(true);
          timer?.cancel();
        }
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  verifyOTP() async {
    otp = fieldOne.text +
        fieldTwo.text +
        fieldThree.text +
        fieldFour.text +
        fieldFive.text +
        fieldSix.text;
    debugPrint(otp);
    //debugPrint(data.toString());

    if (otp.length < 6) {
      toast("Enter OTP");
    } else {
      Get.focusScope?.unfocus();
      if (await isNetConnected()) {
        isLoading(true);
        var otpResponse = await ApiCall().otpVerification(data.mobileno, otp);
        isLoading(false);
        if (otpResponse != null) {
          if (data.appRoleID.isEqual(5)) {
            //roleId 5 is for distributor
            //use conditions to check sales,finance and distributor
            if (otpResponse['Status']) {
              _box.write(Session.userName, data.firstname);
              _box.write(Session.userMobile, data.mobileno);
              _box.write(Session.userMpin, data.mpin);
              _box.write(Session.userId, data.id);
              _box.write(Session.roleId, data.appRoleID);
              _box.write(Session.deviceType, "1");
              _box.write(Session.isLogin, true);
              Get.offAllNamed(AppRoutes.mainScreen);
            }
          } else {
            toast(otpResponse['Message']);
          }
        }
      }
    }
  }

  resendOTP() async {
    Get.focusScope?.unfocus();
    isResend(false);
    final response = await ApiCall().resendOTP(data.mobileno, "abc");
    debugPrint("response: ${response["success"]}");
    if (response != null) {
      toast("${response["message"]}");
    }
  }
}
