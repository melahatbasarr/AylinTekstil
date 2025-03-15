import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/navigator/controller/navigator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorPage extends StatelessWidget {
  NavigatorPage({super.key});

  final NavigatorController _controller = Get.put(NavigatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Obx(() => _controller.pages[_controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => SizedBox(
          height: 80.0,
          child: BottomNavigationBar(
            backgroundColor: CustomColors.textField,
            currentIndex: _controller.currentIndex.value,
            selectedItemColor: CustomColors.color,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: [
              _buildNavigationItem("Anasayfa", "home"),
              _buildNavigationItem("Kategoriler", "categories"),
              _buildNavigationItem("Favoriler", "heart"),
              _buildNavigationItem("Sepetim", "bag"),
              _buildNavigationItem("Profil", "profile"),
            ],
            onTap: (index) {
              _controller.currentIndex.value = index;
            },
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationItem(String label, String icon) {
    return BottomNavigationBarItem(
      label: label,
      icon: ImageIcon(
        AssetImage("assets/icons/$icon.png"),
      ),
    );
  }
}
