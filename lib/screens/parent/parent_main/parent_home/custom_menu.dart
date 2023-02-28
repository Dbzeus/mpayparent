import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpayparent/screens/sales/sales_main/sales_home/sales_home_controller.dart';
import 'package:mpayparent/utils/constant_string.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/custom_colors.dart';
import 'parent_home_controller.dart';

class CustomMenu extends StatelessWidget {
  var menus = [
    {
      'title': 'BankIt',
      'iconUrl': "assets/icon/transfer_money.png",
      'onClickUrl': AppRoutes.parentTopupActivityScreen
    },
    {
      'title': 'Finance',
      'iconUrl': "assets/icon/transfer_status.png",
      'onClickUrl': AppRoutes.parentTopupActivityScreen
    },
    {
      'title': 'Distributor Report',
      'iconUrl': "assets/icon/transfer_report.png",
      'onClickUrl': AppRoutes.parentTopupActivityScreen
    },
    {
      'title': 'Request Topup',
      'iconUrl': "assets/icon/transfer_status.png",
      'onClickUrl': AppRoutes.financeRequestTopupReportScreen
    },
    {
      'title': 'DMT',
      'iconUrl': "assets/icon/transfer_report.png",
      'onClickUrl': AppRoutes.salesDMTReportScreen
    },
    {
      'title': 'My Transaction',
      'iconUrl': "assets/icon/transfer_status.png",
      'onClickUrl': AppRoutes.distributorMyTransactionReportScreen
    },
    {
      'title': 'AEPS Request',
      'iconUrl': "assets/icon/transfer_status.png",
      'onClickUrl': AppRoutes.parentAEPSReportScreen
    },
  ];
  var userMenus = [
    {
      'title': 'Financier',
      'iconUrl': "assets/icon/transfer_money.png",
      'onClickUrl': AppRoutes.userDetailsScreen
    },
    {
      'title': 'Sales',
      'iconUrl': "assets/icon/transfer_status.png",
      'onClickUrl': AppRoutes.userDetailsScreen
    },
    {
      'title': 'Distributor',
      'iconUrl': "assets/icon/transfer_report.png",
      'onClickUrl': AppRoutes.userDetailsScreen
    },
  ];

  CustomMenu(this.controller, {required this.isUser, super.key});

  ParentHomeController controller;
  late bool isUser;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.97,
          crossAxisSpacing: 20,
          mainAxisSpacing: 16),
      itemCount: isUser ? userMenus.length : menus.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return isUser
            ? _buildMenu(userMenus[index]['iconUrl'], userMenus[index]['title'],
                userMenus[index]['onClickUrl'])
            : _buildMenu(menus[index]['iconUrl'], menus[index]['title'],
                menus[index]['onClickUrl']);
      },
    );
  }

  _buildMenu(imagePath, title, onClickUrl) {
    return InkWell(
      onTap: () {
        if (title == "BankIt") {
          Get.toNamed(onClickUrl,
              arguments: {"tType": bankItTypeId, "title": "BankIt Report"});
        } else if (title == "Finance") {
          Get.toNamed(onClickUrl,
              arguments: {"tType": financierTypeId, "title": "Finance Report"});
        } else if (title == "Distributor Report") {
          Get.toNamed(onClickUrl, arguments: {
            "tType": distributorTypeId,
            "title": "Distributor Report"
          });
        } else if (title == "DMT") {
          Get.toNamed(onClickUrl,
              arguments: {"isParent": true, "title": "DMT Report"});
        } else if (title == "Financier") {
          Get.toNamed(onClickUrl, arguments: {
            "roleId": financeRoleId,
            "title": "Financier Details"
          });
        } else if (title == "Sales") {
          Get.toNamed(onClickUrl,
              arguments: {"roleId": saleRoleId, "title": "Sales Details"});
        } else if (title == "Distributor") {
          Get.toNamed(onClickUrl, arguments: {
            "roleId": distributorRoleId,
            "title": "Distributor Details"
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
