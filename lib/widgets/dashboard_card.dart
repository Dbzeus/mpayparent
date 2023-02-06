import 'package:flutter/material.dart';

import '../utils/constant_string.dart';
import '../utils/custom_colors.dart';

class DashboardCard extends StatelessWidget {
  DashboardCard(this.title,this.value,{Key? key,this.onTab}) : super(key: key);

  String title;
  String value;
  Function()? onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: primaryColor,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 14, color: textColor, fontWeight: FontWeight.w800)),
            const SizedBox(
              height: 8,
            ),
            Text(
              "$rs $value",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 23,
                color: textColor,
                letterSpacing: 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
