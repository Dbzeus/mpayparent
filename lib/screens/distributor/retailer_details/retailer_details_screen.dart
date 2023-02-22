import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/model/retailerDetailsResponse.dart';
import 'package:mpayparent/screens/distributor/retailer_details/retailer_details_controller.dart';

import '../../../widgets/custom_edittext.dart';

class DIRetailerDetailsScreen extends GetView<DIRetailerDetailsController> {
  @override
  final controller = Get.put(DIRetailerDetailsController());

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

  DIRetailerDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Retailer"),
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
                    : controller.retailerDetails.isEmpty
                        ? const Center(
                            child: Text('No Retailers Found'),
                          )
                        : ListView.builder(
                            itemCount: controller.retailerDetails.length,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (__, index) =>
                                _showRetailerDetailsReport(
                                    controller.retailerDetails[index]),
                          ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  _showRetailerDetailsReport(RetailerResponseReturnData retailerData) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.all(8),
      decoration: boxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: retailerData.isActive ? Colors.green : Colors.red,
            child: CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(
                  retailerData.profilePhoto,
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
                Text(retailerData.firstName, //response.firstName,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w800)),
                Text(retailerData.organisationName,
                    //response.mobileNo.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    )),
                Text(retailerData.mobileNo,
                    style: const TextStyle(
                      fontSize: 14,
                    )),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}
