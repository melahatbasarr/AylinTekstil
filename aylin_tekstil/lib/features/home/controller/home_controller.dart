import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  late PageController pageController;

  final RxInt selectedPageIndex = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxList<HomeModel> filteredCategories = <HomeModel>[].obs;
  final List<HomeModel> allCategories = [];

  final RxList<HomeModel> categories = <HomeModel>[
    HomeModel(
      id: '1',
      name: "Soğuk Triko",
      colorImages: {
        "Red": "assets/images/green_bluz.png",
        "Blue": "assets/images/green_bluz.png",
        "Green": "assets/images/green_bluz.png",
        "Purple": "assets/images/green_bluz.png",
        "Black": "assets/images/green_bluz.png",
        "Yellow": "assets/images/green_bluz.png",
      },
      amount: "180.00 ₺",
      group: "Spor triko grubu",
      description: "Yumuşacık ve kaliteli triko kazaklarımızla rahatlığı ve şıklığı bir arada yaşayın.",
      availableColors: ["Red", "Blue", "Green", "Purple", "Black", "Yellow"],
      isFavorited: false,
      selectedColor: "Green",
    ),
    HomeModel(
      id: '2',
      name: "Kırmızı Triko",
      colorImages: {
        "Red": "assets/images/red_bluz.png",
        "Blue": "assets/images/red_bluz.png",
        "Green": "assets/images/red_bluz.png",
        "Purple": "assets/images/red_bluz.png",
        "Black": "assets/images/red_bluz.png",
        "Yellow": "assets/images/red_bluz.png",
      },
      amount: "180.00 ₺",
      group: "Spor triko grubu",
      description: "Yumuşacık ve kaliteli triko kazaklarımızla rahatlığı ve şıklığı bir arada yaşayın.",
      availableColors: ["Red", "Blue", "Green", "Purple", "Black", "Yellow"],
      isFavorited: false,
      selectedColor: "Red",
    ),
  ].obs;

  final List<String> imagePaths = List.generate(5, (index) => 'assets/images/scroll.png');

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    allCategories.addAll(categories);
    filteredCategories.addAll(categories);
    ever(searchQuery, _filterCategories);
  }

  @override void onClose() {
    super.onClose();
  }
  

  void onPageChanged(int index) {
    selectedPageIndex.value = index;
  }

  bool isFavorited(int index) {
    return index >= 0 && index < categories.length
        ? categories[index].isFavorited
        : false;
  }

  void selectColor(int index, String color) {
    if (index >= 0 && index < categories.length) {
      categories[index] = categories[index].copyWith(
        selectedColor: color,
      );
    }
  }

  void toggleFavorite(int index) {
    if (index >= 0 && index < categories.length) {
      final HomeModel = categories[index];
      categories[index] = HomeModel.copyWith(
        isFavorited: !HomeModel.isFavorited,
      );
    }
  }

  String getImageForColor(int index) {
    if (index >= 0 && index < categories.length) {
      final selectedColor = categories[index].selectedColor;
      return categories[index].colorImages[selectedColor] ?? '';
    }
    return '';
  }

  void addHomeModel(HomeModel newHomeModel) {
    categories.add(newHomeModel);
    allCategories.add(newHomeModel);
    _filterCategories(searchQuery.value);
  }

  void updateHomeModel(int index, HomeModel updatedHomeModel) {
    if (index >= 0 && index < categories.length) {
      categories[index] = updatedHomeModel;
      allCategories[index] = updatedHomeModel;
      _filterCategories(searchQuery.value);
    }
  }

  void removeHomeModel(int index) {
    if (index >= 0 && index < categories.length) {
      categories.removeAt(index);
      allCategories.removeAt(index);
      _filterCategories(searchQuery.value);
    }
  }

  List<HomeModel> searchCategories(String query) {
    return allCategories.where((HomeModel) {
      return HomeModel.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void _filterCategories(String query) {
    if (query.isEmpty) {
      filteredCategories.value = List.from(allCategories);
    } else {
      filteredCategories.value = searchCategories(query);
    }
  }
}
