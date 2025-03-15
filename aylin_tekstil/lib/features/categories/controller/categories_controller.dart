import 'package:get/get.dart';
import '../model/categories_model.dart';
import '../repository/categories_repository.dart';

class CategoriesController extends GetxController {
  final CategoriesRepository _repository = CategoriesRepository();

  final RxList<HomeModel> categories = <HomeModel>[
    HomeModel(
      name: "Bluz",
      imagePath: "assets/images/bluz.png",
      route: "/bluzPage",
    ),
    HomeModel(
      name: "Tunik",
      imagePath: "assets/images/tunik.png",
      route: "/tunikPage",
    ),
    HomeModel(
      name: "Takım",
      imagePath: "assets/images/takim.png",
      route: "/takimPage",
    ),
    HomeModel(
      name: "Yelek",
      imagePath: "assets/images/yelek.png",
      route: "/yelekPage",
    ),
    HomeModel(
      name: "Ceket",
      imagePath: "assets/images/jacket_one.png",
      route: "/bluzPage",
    ),
    HomeModel(
      name: "Ceket",
      imagePath: "assets/images/jacket_two.png",
      route: "/bluzPage",
    ),
  ].obs;

  @override
  void onClose() {
    super.onClose();
  }
}
