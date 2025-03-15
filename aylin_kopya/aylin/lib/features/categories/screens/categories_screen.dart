import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/categories/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aylin/common/widget/categories_button.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final CategoriesController _controller = Get.find<CategoriesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Kategoriler"),
      body: Obx(() {
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio:
                0.8, // Oranı düşürerek daha uzun ve dar hücreler oluşturabilirsiniz.
          ),
          itemCount: _controller.categories.length,
          itemBuilder: (context, index) {
            final homeModel = _controller.categories[index];
            return CategoriesButton(
              onTap: () {
                Get.toNamed(homeModel.route);
              },
              color: CustomColors.textField,
              text: homeModel.name,
              child: Image.asset(
                homeModel.imagePath,
              ),
            );
          },
        );
      }),
    );
  }
}
