import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessfulOrderPage extends StatelessWidget {
  const SuccessfulOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.textField,
      appBar: CustomWidgets.appBar("Sipariş"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 150,
                    color: CustomColors.color,
                  ),
                  const SizedBox(height: 5),
                  CustomWidgets.pageTitle("Sipariş Alındı"),
                  const SizedBox(height: 15),
                  CustomWidgets.expText(
                      "Ön siparişin alındı, ekibimiz en kısa sürede sizinle iletişime geçecektir."),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: BrownButton(
                title: "Tamam",
                onTap: () {
                  Get.toNamed('/navigatorPage');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
