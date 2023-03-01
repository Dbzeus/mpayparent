import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/screens/sales/sales_main/sales_home/sales_home_controller.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/custom_colors.dart';

class CustomMenu extends StatelessWidget {
  var menus = [
    {
      'title': 'Distributor',
      'iconUrl': "assets/icon/transfer_money.png",
      'onClickUrl': AppRoutes.salesDistributorScreen
    },
    {
      'title': 'Topup',
      'iconUrl': "assets/icon/transfer_status.png",
      'onClickUrl': AppRoutes.salesTopupReportScreen
    },
    {
      'title': 'DMT Transaction',
      'iconUrl': "assets/icon/transfer_report.png",
      'onClickUrl': AppRoutes.salesDMTReportScreen
    },
  ];

  CustomMenu(this.controller, {super.key});

  SalesHomeController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.97,
          crossAxisSpacing: 20,
          mainAxisSpacing: 16),
      itemCount: menus.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return _buildMenu(menus[index]['iconUrl'], menus[index]['title'],
            menus[index]['onClickUrl']);
      },
    );
  }

  _buildMenu(imagePath, title, onClickUrl) {
    return InkWell(
      onTap: () {
        if (title == "DMT Transaction") {
          Get.toNamed(onClickUrl, arguments: {
            "isParent": false,
            "title": "DMT Transaction Report"
          });
        } else {
          Get.toNamed(onClickUrl);
        }
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primaryColor, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 35,
                width: 35,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis)),
            ],
          )),
    );
  }
}
