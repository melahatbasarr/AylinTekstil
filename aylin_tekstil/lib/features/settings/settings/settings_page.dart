import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/settings/delete_account/screens/account_deletion_page.dart';
import 'package:aylin/features/settings/annonuncement/screen/announcement_page.dart';
import 'package:aylin/features/settings/update_password/screens/update_password_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        "icon": Icons.notifications_outlined,
        "text": "Bildirim Tercihlerim",
        "page": const AnnouncementPage()
      },
      {
        "icon": Icons.lock_outline,
        "text": "Şifre Güncelle",
        "page": const UpdatePasswordPage() 
      },
      {
        "icon": Icons.delete_outline,
        "text": "Hesap Silme İsteği",
        "page": const AccountDeletionPage()
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Settings"),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: Icon(
              item["icon"],
              color: CustomColors.color,
            ),
            title: CustomWidgets.settingBlackText(item["text"]),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: CustomColors.color,
            ),
            onTap: () {
              _navigateToPage(item["page"]);
            },
          );
        },
      ),
    );
  }

  void _navigateToPage(Widget page) {
    try {
      Get.to(() => page);
    } catch (e) {
      print('Error during navigation: $e');
    }
  }
}
