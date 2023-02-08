import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../api/api_call.dart';
import '../../../model/user_login_response.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/constant_function.dart';
import '../../../utils/constant_widgets.dart';

class LoginController extends GetxController {
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController mpinController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString appVersion = '-'.obs;

  @override
  void onInit() async {
    super.onInit();
    appVersion(await getAppVersion());
  }

  logIn() async {
    if (mobileNoController.text.length != 10) {
      toast("Enter mobile number");
    } else if (mpinController.text.length != 4) {
      toast("Enter mpin");
    } else {
      Get.focusScope?.unfocus();

      if (await isNetConnected()) {
        isLoading(true);
        // String token = (await FirebaseMessaging.instance.getToken()) ?? '';
        var loginResponse = await ApiCall().checkLogin(
            mobileNoController.text, mpinController.text, ""); //LogIn
        isLoading(false);

        if (loginResponse != null && loginResponse['Status']) {
          var userData = UserData.fromJson(loginResponse['ReturnData']);
          var deviceCheckResponse = await ApiCall().checkDevice(userData.id,
              await getId()); //checking the Multiple login in mobile device
          if (deviceCheckResponse !=
              null /*&& deviceCheckResponse["Status"]*/) {
            Get.toNamed(AppRoutes.otpScreen, arguments: {
              "userData": userData,
            });
          } else {
            showCustomAlertDialog(
                title: 'Multiple login?',
                content: deviceCheckResponse['Message']);
          }
        } else {
          toast(loginResponse?["Message"]);
        }
      }
    }
  }
}
