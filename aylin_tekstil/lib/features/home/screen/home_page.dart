import 'dart:async';
import 'package:aylin/common/widget/categories_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/categories/screens/categories_screen.dart';
import 'package:aylin/features/home/controller/home_controller.dart';
import 'package:aylin/features/home/screen/filter_page.dart';
import 'package:aylin/features/search/screen/search_results_page.dart';
import 'package:aylin/features/product_detail/screens/product_detail_page.dart';
import 'package:aylin/features/settings/notification_preferences/screens/notification_page.dart';
import 'package:aylin/features/categories/controller/categories_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = Get.put(HomeController());

  final CategoriesController _categoriesController =
      Get.put(CategoriesController());
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_controller.pageController.hasClients) {
        int nextPage = (_controller.pageController.page?.toInt() ?? 0) + 1;
        if (nextPage >= _controller.imagePaths.length) {
          nextPage = 0;
        }
        _controller.pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 130,
                  height: 44,
                ),
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Get.to(() => const NotificationPage());
                  },
                ),
              ],
            ),
          ),
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildImageSlider(),
          const SizedBox(height: 20),
          _buildPageIndicator(),
          const SizedBox(height: 20),
          _buildCategoriesText(),
          const SizedBox(height: 20),
          _buildCategoriesSlider(),
          _buildFavories(),
        ],
      ),
    );
  }

  Widget _buildImageSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: SizedBox(
        height: 165,
        width: double.infinity,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: PageView.builder(
              controller: _controller.pageController,
              onPageChanged: _controller.onPageChanged,
              itemCount: _controller.imagePaths.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    _controller.imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavories() {
    return Obx(
      () => SizedBox(
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.8,
          ),
          itemCount: _controller.categories.length,
          itemBuilder: (context, index) {
            // ignore: non_constant_identifier_names
            final HomeModel = _controller.categories[index];
            final imagePath =
                HomeModel.colorImages[HomeModel.selectedColor] ?? '';

            return GestureDetector(
              onTap: () {
                Get.to(() => const ProductDetailPage(), arguments: HomeModel);
              },
              child: Stack(
                children: [
                  Card(
                    color: CustomColors.textField,
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
                            CustomWidgets.blackText(HomeModel.name),
                            const SizedBox(height: 4.0),
                            CustomWidgets.blackText(HomeModel.amount),
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
                        HomeModel.isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: HomeModel.isFavorited
                            ? CustomColors.color
                            : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.toggleFavorite(index);
                        });
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
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

  Widget _buildPageIndicator() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          _controller.imagePaths.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: _controller.selectedPageIndex.value == index ? 12 : 10,
            height: _controller.selectedPageIndex.value == index ? 12 : 9,
            decoration: BoxDecoration(
              color: _controller.selectedPageIndex.value == index
                  ? CustomColors.color
                  : CustomColors.backgroundColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Ara...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                _controller.searchQuery.value = value;
              },
              onSubmitted: (value) {
                Get.to(() => const SearchResultsPage());
              },
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: CustomColors.color,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.white),
              onPressed: () {
                Get.to(() => const FilterPage());
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categoriesController.categories.length,
          itemBuilder: (context, index) {
            // ignore: non_constant_identifier_names
            final HomeModel = _categoriesController.categories[index];
            final routeName = '/${HomeModel.name.toLowerCase()}Page';
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CategoriesButton(
                text: HomeModel.name,
                onTap: () {
                  Get.toNamed(routeName);
                },
                child: Image.asset(
                  HomeModel.imagePath,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoriesText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomWidgets.settingBlackText("Kategoriler"),
          InkWell(
            onTap: () {
              Get.to(() => const CategoriesPage());
            },
            child: CustomWidgets.greenText("Tümünü Gör"),
          ),
        ],
      ),
    );
  }
}
