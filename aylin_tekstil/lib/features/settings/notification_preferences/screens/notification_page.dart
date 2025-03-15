import 'package:aylin/features/settings/notification_preferences/screens/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';


class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Notification"),
      body:const Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TODAY",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Inter",
                    color: CustomColors.lightGreenText,
                  ),
                ),
                Text(
                  "Mark all as read",
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomColors.color,
                  ),
                ),
              ],
            ),
             SizedBox(height: 20),
            NotificationItem(
              imagePath: 'assets/icons/notif_one.png',
              title: "Order Shipped",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            ),
           SizedBox(height: 30),
            NotificationItem(
              imagePath: 'assets/icons/notif_two.png',
              title: "Flash Sale Alert",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            ),
            SizedBox(height: 30),
            NotificationItem(
              imagePath: 'assets/icons/notif_three.png',
              title: "Product Review Request",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis.",
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "YESTERDAY",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Inter",
                    color: CustomColors.lightGreenText,
                  ),
                ),
                Text(
                  "Mark all as read",
                  style: TextStyle(
                    fontSize: 15,
                    color: CustomColors.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            NotificationItem(
              imagePath: 'assets/icons/notif_three.png',
              title: "Order Shipped",
              description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis.",
            ),
          ]
        ),
      ),
    );
  }
}
