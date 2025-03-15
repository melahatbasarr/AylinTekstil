import 'package:flutter/material.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/common/widget/custom_widgets.dart';

class NotificationItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const NotificationItem({super.key, 
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomWidgets.greyCircular(
          diameter: 60.0,
          color: CustomColors.textField,
          borderWidth: 2.0,
          imagePath: imagePath,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomWidgets.settingBlackText(title),
              const SizedBox(height: 5),
              CustomWidgets.expTextTwo(description),
            ],
          ),
        ),
      ],
    );
  }
}
