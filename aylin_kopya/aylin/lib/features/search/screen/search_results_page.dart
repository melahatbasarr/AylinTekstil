import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/features/product_detail/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controller/home_controller.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController _controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16.0, top: 50.0, right: 16.0),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Obx(() {
                      return TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 8.0),
                          hintText: _controller.searchQuery.value.isEmpty
                              ? 'Arama'
                              : _controller.searchQuery.value,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.black),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.close, color: Colors.black),
                            onPressed: () {
                              _controller.searchQuery.value = '';
                            },
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.black, fontSize: 18.0),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Obx(() {
              final query = _controller.searchQuery.value;
              final resultCount = _controller.filteredCategories.length;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomWidgets.settingBlackText('"$query" için sonuçlar'),
                  CustomWidgets.greenText('$resultCount sonuç '),
                ],
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              final filteredCategories = _controller.filteredCategories;

              if (filteredCategories.isEmpty) {
                return const Center(child: Text('Sonuç bulunamadı'));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  final HomeModel = filteredCategories[index];
                  final imagePath =
                      HomeModel.colorImages[HomeModel.selectedColor] ?? '';

                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => const ProductDetailPage(),
                        arguments: HomeModel,
                      );
                    },
                    child: Card(
                      color: Colors.white,
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
                                  : const Center(child: Text('Görsel Yok')),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                HomeModel.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4.0),
                              Text(HomeModel.amount),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
