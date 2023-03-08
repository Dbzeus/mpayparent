import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../../../api/api_call.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/constant_function.dart';
import '../../../utils/constant_string.dart';
import '../../../utils/constant_widgets.dart';
import '../../../utils/custom_colors.dart';
import '../../../utils/session.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString appVersion = '-'.obs;
  final box = GetStorage();
  RxString profileImage = "".obs;

  @override
  void onInit() async {
    profileImage(box.read(Session.profileImage));
    super.onInit();
    appVersion(await getAppVersion());
  }

  logoutDialog() {
    showCustomAlertDialog(
      title: "Logout?",
      content: "Are you sure want to Logout?",
      confirm: "Logout",
      onTabConfirm: () {
        logout();
      },
      cancel: "Cancel",
    );
  }

  logout() async {
    if (await isNetConnected()) {
      isLoading(true);
      var logoutResponse = await ApiCall()
          .logoutDevice(box.read(Session.userId).toString(), "1");
      isLoading(false);
      if (logoutResponse != null && logoutResponse["Status"]) {
        box.erase();
        Get.offAllNamed(AppRoutes.loginScreen);
        toast("Logged Out Successfully");
      }
    }
  }

  showSupportSheet() {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height * 0.2,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            )),
        child: Column(
          children: [
            ListTile(
              title: const Text(supportMobileNo),
              trailing: InkWell(
                onTap: () => launchUrlString('tel://$supportMobileNo'),
                child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryButtonColor),
                    child: const Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 20,
                    )),
              ),
            ),
            const Divider(
              indent: 24,
              endIndent: 24,
            ),
            ListTile(
              title: const Text(supportMailId),
              trailing: InkWell(
                onTap: () => launchUrlString('mailto:$supportMailId'),
                child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: primaryButtonColor),
                    child: const Icon(
                      Icons.mail,
                      color: Colors.white,
                      size: 20,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
