import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/retailerDetailsResponse.dart';
import 'package:mpayparent/routes/app_routes.dart';
import 'package:mpayparent/screens/common/user_details_and_create/user_details/user_details_controller.dart';
import 'package:mpayparent/screens/distributor/retailer_details/retailer_details_controller.dart';
import 'package:mpayparent/screens/parent/model/userList.dart';
import 'package:mpayparent/utils/constant_string.dart';

import '../../../../widgets/custom_edittext.dart';

class UserDetailsScreen extends GetView<UserDetailsController> {
  @override
  final controller = Get.put(UserDetailsController());

  var boxDecoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
          spreadRadius: 1,
          blurRadius: 1,
          color: Color.fromRGBO(237, 237, 237, 1),
        )
      ]);

  UserDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Obx(() => Text(controller.title.value)),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: CustomEditText(
                controller: controller.searchController,
                hintText: "Search",
                maxLines: 1,
                onChanged: (text) {
                  controller.onSearchChanged(text);
                },
                suffixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.userList.isEmpty
                        ? const Center(
                            child: Text('No User Found'),
                          )
                        : ListView.builder(
                            itemCount: controller.userList.length,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (__, index) =>
                                _showRetailerDetailsReport(
                                    controller.userList[index]),
                          ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (controller.roleId.isEqual(financeRoleId)) {
              Get.toNamed(AppRoutes.userCreateScreen, arguments: {
                "title": "Create Financier",
                "roleId": controller.roleId,
              });
            } else if (controller.roleId.isEqual(saleRoleId)) {
              Get.toNamed(AppRoutes.userCreateScreen, arguments: {
                "title": "Create Sales User",
                "roleId": controller.roleId,
              });
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _showRetailerDetailsReport(UserListReturnData userData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.all(8),
      decoration: boxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: userData.isActive ? Colors.green : Colors.red,
            child: CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(
                  userData.profileImage,
                )),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(userData.firstName, //response.firstName,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w800)),
                Text(userData.lastName,
                    //response.mobileNo.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    )),
                Text(userData.mobileNo,
                    style: const TextStyle(
                      fontSize: 14,
                    )),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                if (controller.roleId.isEqual(financeRoleId)) {
                  Get.toNamed(AppRoutes.userCreateScreen, arguments: {
                    "title": "Edit Financier",
                    "roleId": controller.roleId,
                    "userData": userData
                  });
                } else if (controller.roleId.isEqual(saleRoleId)) {
                  Get.toNamed(AppRoutes.userCreateScreen, arguments: {
                    "title": "Edit Sales User",
                    "roleId": controller.roleId,
                    "userData": userData
                  });
                }
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}
