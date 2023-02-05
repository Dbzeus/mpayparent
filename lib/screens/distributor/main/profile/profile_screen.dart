import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/screens/distributor/main/profile/profile_controller.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../../../../utils/constant_function.dart';
import '../../../../utils/custom_colors.dart';
import '../../../../utils/session.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(ProfileController());

  var boxDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      boxShadow: [
        BoxShadow(
          spreadRadius: 2,
          blurRadius: 2,
          color: Color.fromRGBO(237, 237, 237, 1),
        )
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Container(
                  decoration: boxDecoration,
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/icon/p.png',
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("${controller.box.read(Session.userName)}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                              "${maskedOutput(controller.box.read(Session.userMobile))}",
                              //controller.userName,
                              style: const TextStyle(
                                fontSize: 12,
                              )),
                          // const SizedBox(
                          //   height: 4,
                          // ),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 4, horizontal: 8),
                          //   decoration: BoxDecoration(
                          //       color: secondaryColor,
                          //       borderRadius: BorderRadius.circular(12)),
                          //   child: const Text(
                          //     'Retailer',
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    width: Get.width,
                    decoration: boxDecoration,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        _buildMenu('assets/icon/aboutus.png', 'About Us', () {
                          launchUrlString('https://mpayy.co.in/about/',
                              mode: LaunchMode.externalApplication);
                        }),
                        const Divider(),
                        _buildMenu('assets/icon/tc.png', 'Terms & Conditions',
                            () {
                          launchUrlString(
                              'https://mpayy.co.in/terms-conditions/',
                              mode: LaunchMode.externalApplication);
                        }),
                        const Divider(),
                        _buildMenu('assets/icon/privacy.png', 'Privacy Policy',
                            () {
                          launchUrlString('https://mpayy.co.in/privacy-policy',
                              mode: LaunchMode.externalApplication);
                        }),
                        const Divider(),
                        _buildMenu(
                            'assets/icon/customer_support.png',
                            'Customer Support',
                            () => controller.showSupportSheet()),
                      ],
                    )),
                const SizedBox(
                  height: 24,
                ),
                Container(
                    width: Get.width,
                    decoration: boxDecoration,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        _buildMenu(Icons.logout, 'Logout',
                            () => controller.logoutDialog()),
                      ],
                    )),
                const SizedBox(
                  height: 32,
                ),
                const Text('A Product of'),
                Image.asset(
                  'assets/icon/chrimata.png',
                  height: 40,
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(() => Text('App Version ${controller.appVersion}')),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
          Obx(() => controller.isLoading.value
              ? Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black12,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  _buildMenu(dynamic icon, String name, Function() onTab) {
    return InkWell(
      onTap: onTab,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryButtonColor),
              child: icon is String
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        icon,
                      ),
                    )
                  : Icon(
                      icon,
                      color: Colors.white,
                      size: 20,
                    )),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 15,
          ),
        ],
      ),
    );
  }
}
