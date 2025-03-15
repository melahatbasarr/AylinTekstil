import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/model/home_model.dart';

class FavoriesController extends GetxController {
  var categories = <HomeModel>[].obs;

  void removeFromFavoritesWithUndo(HomeModel HomeModel) {
    HomeModel.isFavorited = false;
    update();

    Get.showSnackbar(GetSnackBar(
      message: '${HomeModel.name} favorilerden kaldırıldı',
      duration: const Duration(seconds: 3),
      mainButton: TextButton(
        onPressed: () {
          HomeModel.isFavorited = true;
          update();
          Get.back();
        },
        child: const Text('Geri Al'),
      ),
    ));

    Future.delayed(const Duration(seconds: 3), () {
      if (!HomeModel.isFavorited) {
        categories.remove(HomeModel);
      }
    });
  }

  void addToFavorites(HomeModel HomeModel) {
    if (!categories.any((c) => c.id == HomeModel.id)) {
      HomeModel.isFavorited = true;
      categories.add(HomeModel);
    }
  }

  void removeFromFavorites(HomeModel HomeModel) {
    HomeModel.isFavorited = false;
    categories.removeWhere((c) => c.id == HomeModel.id);
  }
}
