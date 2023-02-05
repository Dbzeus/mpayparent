import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upgrader/upgrader.dart';

import '../home/home_screen.dart';
import '../notification/notification_screen.dart';
import '../profile/profile_screen.dart';
import 'bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final pages = [HomeScreen(), NotificationScreen(), ProfileScreen()];

  RxInt selectedIndex = 0.obs;

  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(
        canDismissDialog: false,
        showIgnore: false,
        showLater: false,
      ),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: selectedIndex,
            onChange: (index) {
              _pageController.jumpToPage(index);
            }),
      ),
    );
  }
}
