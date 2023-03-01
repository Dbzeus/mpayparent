import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/retailerDetailsResponse.dart';
import 'package:mpayparent/utils/constant_string.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/custom_edittext.dart';
import 'sa_di_details_controller.dart';

class SADistributorScreen extends GetView<SADistributorController> {
  @override
  final controller = Get.put(SADistributorController());

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

  SADistributorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Distributor"),
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
                    : controller.distributorDetails.isEmpty
                        ? const Center(
                            child: Text('No Retailers Found'),
                          )
                        : ListView.builder(
                            itemCount: controller.distributorDetails.length,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (__, index) =>
                                _showDistributorDetailsReport(
                                    controller.distributorDetails[index]),
                          ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var res = await Get.toNamed(AppRoutes.distributorCreateScreen,
                arguments: {
                  "title": "Create Distributor User",
                  "roleId": distributorRoleId,
                });
            if (res != null && res) {
              controller.getDistributorDetails();
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _showDistributorDetailsReport(RetailerResponseReturnData distributorData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.all(8),
      decoration: boxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor:
                distributorData.isActive ? Colors.green : Colors.red,
            child: CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(
                  distributorData.profilePhoto,
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
                Text(distributorData.firstName, //response.firstName,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w800)),
                Text(distributorData.organisationName,
                    //response.mobileNo.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    )),
                Text(distributorData.mobileNo,
                    style: const TextStyle(
                      fontSize: 14,
                    )),
              ],
            ),
          ),
          IconButton(
              onPressed: () async {
                var res = await Get.toNamed(AppRoutes.distributorCreateScreen,
                    arguments: {
                      "title": "Edit Distributor User",
                      "roleId": distributorRoleId,
                      "userData": distributorData
                    });
                if (res != null && res) {
                  controller.getDistributorDetails();
                }
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}
