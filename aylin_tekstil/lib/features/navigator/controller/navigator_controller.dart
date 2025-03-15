import 'package:aylin/features/home/screen/home_page.dart';
import 'package:aylin/features/categories/screens/categories_screen.dart';
import 'package:aylin/features/favories/screen/favories_screen.dart';
import 'package:aylin/features/basket/screen/basket_page.dart';
import 'package:aylin/features/profile/profile/profile_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NavigatorController extends GetxController {
  RxInt currentIndex = 0.obs;

  List<Widget> pages = [
    HomePage(),
    CategoriesPage(),
    FavoriesPage(),
    BasketPage(),
    ProfilePage(),
  ];
}
