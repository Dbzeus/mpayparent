import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mpayparent/model/retailerDetailsResponse.dart';
import 'package:mpayparent/model/user_login_response.dart';
import 'package:mpayparent/screens/distributor/retailer_details/retailer_details_controller.dart';

import '../../../utils/constant_string.dart';
import '../../../widgets/custom_edittext.dart';

class RetailerDetailsScreen extends GetView<RetailerDetailsController> {
  final controller = Get.put(RetailerDetailsController());
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
  RetailerDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retailer"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: CustomEditText(
                controller: controller.searchController,
                hintText: "Search",
                maxLines: 1,
                onChanged: (text) {
                  //controller.onSearchChanged(text);
                },
                suffixIcon: const Icon(
                  Icons.search,
                  size: 20,
                ),
              ),
            ),
            Obx(
              () => ListView.builder(
                itemCount: controller.retailerDetails.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (__, index) => _showRetailerDetailsReport(
                    controller.retailerDetails[index]),
              ),
            )
          ],
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              backgroundImage: NetworkImage(retailerData.profilePhoto)),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(retailerData.firstName, //response.firstName,
                  style: const TextStyle(
                    fontSize: 14,
                  )),
              Text(
                  retailerData.organisationName, //response.mobileNo.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                  )),
              Text(retailerData.mobileNo,
                  style: const TextStyle(
                    fontSize: 14,
                  )),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: retailerData.isActive ? Colors.green : Colors.red),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: boxDecoration,
                      child: Icon(Icons.edit)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
