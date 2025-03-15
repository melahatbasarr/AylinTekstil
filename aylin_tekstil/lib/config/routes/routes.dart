import 'package:aylin/features/basket/screen/basket_page.dart';
import 'package:aylin/features/favories/screen/favories_screen.dart';
import 'package:aylin/features/home/screen/home_page.dart';
import 'package:aylin/features/navigator/screens/navigator_page.dart';
import 'package:aylin/features/profile/profile/profile_page.dart';
import 'package:get/get.dart';
import 'package:aylin/features/categories/screens/bluz_page.dart';
import 'package:aylin/features/categories/screens/categories_screen.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: '/', page: () => const CategoriesPage()),
    GetPage(name: '/bluzPage', page: () => const BluzPage()),
    GetPage(name: '/tunikPage', page: () => const BluzPage()),
    GetPage(name: '/takimPage', page: () => const BluzPage()),
    GetPage(name: '/yelekPage', page: () => const BluzPage()),
    GetPage(name: '/homePage', page: () => const HomePage()),
    GetPage(name: '/categoriesPage', page: () => const CategoriesPage()),
    GetPage(name: '/favoriesPage', page: () => const FavoriesPage()),
    GetPage(name: '/basketPage', page: () => const BasketPage()),
    GetPage(name: '/profilePage', page: () => const ProfilePage()),
    GetPage(name:'/navigatorPage',page: ()=>NavigatorPage()),
  ];
}
