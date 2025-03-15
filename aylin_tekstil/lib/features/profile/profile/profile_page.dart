import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/auth/login/screens/login_page.dart';
import 'package:aylin/features/profile/my_orders/screens/my_orders_page.dart';
import 'package:aylin/features/profile/profile/controller/profile_controller.dart';
import 'package:aylin/features/addresses/addresses/screens/addresses_page.dart';
import 'package:aylin/features/settings/update_profile/screens/edit_profile_page.dart';
import 'package:aylin/features/settings/privacy_policy/screens/privacy_policy_page.dart';
import 'package:aylin/features/settings/settings/settings_page.dart';
import 'package:aylin/features/settings/get_support/screens/support_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController _controller = Get.find<ProfileController>();

    final List<Map<String, dynamic>> items = [
      {
        "icon": Icons.account_circle_outlined,
        "text": "Profili Düzenle",
        "page": EditProfilePage()
      },
      {
        "icon": Icons.location_on_outlined,
        "text": "Adreslerim",
        "page": const AddressesPage()
      },
      {
        "icon": Icons.shopping_bag_outlined,
        "text": "Siparişlerim",
        "page": const MyOrdersPage()
      },
      {
        "icon": Icons.settings_outlined,
        "text": "Ayarlar",
        "page": const SettingsPage()
      },
      {
        "icon": Icons.lock_outline,
        "text": "Gizlilik Politikası",
        "page": const PrivacyPolicyPage()
      },
      {
        "icon": Icons.help_outline,
        "text": "Destek Al",
        "page": const SupportPage()
      },
      {
        "icon": Icons.exit_to_app,
        "text": "Çıkış Yap",
        "page": LoginPage()
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Profilim"),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 150),
            child: Column(
              children: [
                const Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: CustomColors.textField,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: CustomColors.color,
                          child: Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Obx(() {
                  final profile = _controller.profile.value;
                  return Text(
                    '${profile.firstName} ${profile.lastName}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Icon(item["icon"], color: CustomColors.color),
                  title: CustomWidgets.settingBlackText(item["text"]),
                  onTap: () {
                    if (item["text"] == "Çıkış Yap") {
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => item["page"]),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
