import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/custom_colors.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  CustomBottomNavigationBar(
      {Key? key, required this.selectedIndex, required this.onChange})
      : super(key: key);

  RxInt selectedIndex;
  Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 60,
        width: Get.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenu(0, Icons.home, 'Home'),
            //_buildMenu(1, Icons.dashboard, 'Dashboard'),
            _buildMenu(1, Icons.notifications_rounded, 'Notification'),
            _buildMenu(2, Icons.person, 'Profile'),
          ],
        ),
      ),
    );
  }

  _buildMenu(
    int index,
    IconData icon,
    String title,
  ) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (selectedIndex.value != index) {
            selectedIndex(index);
            onChange(index);
          }
        },
        child: Obx(
          () => Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selectedIndex.value == index ? textColor : null,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 20,
                    color:
                        selectedIndex.value == index ? Colors.black : textColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  selectedIndex.value == index
                      ? Text(
                          title,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
