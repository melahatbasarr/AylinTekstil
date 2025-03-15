import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aylin/features/home/controller/home_controller.dart';
import 'package:aylin/features/product_detail/screens/product_detail_page.dart';

class FavoriesPage extends StatelessWidget {
  const FavoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Favoriler"),
      body: Obx(
        () => GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.8,
          ),
          itemCount: _controller.categories.where((c) => c.isFavorited).length,
          itemBuilder: (context, index) {
            final HomeModel = _controller.categories
                .where((c) => c.isFavorited)
                .toList()[index];
            final imagePath =
                HomeModel.colorImages[HomeModel.selectedColor] ?? '';

            return GestureDetector(
              onTap: () {
                Get.to(() => const ProductDetailPage(), arguments: HomeModel);
              },
              child: Stack(
                children: [
                  Card(
                    color: const Color(0xFFF6F6F6),
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: imagePath.isNotEmpty
                                ? Image.asset(
                                    imagePath,
                                    fit: BoxFit.cover,
                                  )
                                : const Center(child: Text('No Image')),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              HomeModel.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4.0),
                            Text(HomeModel.amount),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: HomeModel.isFavorited
                            ? CustomColors.color
                            : Colors.grey,
                      ),
                      onPressed: () {
                        _controller.toggleFavorite(
                          _controller.categories.indexOf(HomeModel),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
