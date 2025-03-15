import 'package:aylin/common/widget/defeault_textfield.dart';
import 'package:flutter/material.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:get/get.dart';
import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/features/profile/profile/controller/profile_controller.dart';
import 'package:aylin/features/profile/profile/profile_page.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final ProfileController _profileController = Get.find();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profile = _profileController.profile.value;

    _phoneController.text = profile.phoneNumber ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar(""),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        children: [
          Center(
            child: Column(
              children: [
                CustomWidgets.pageTitle("Profil Düzenle"),
                const SizedBox(height: 45),
                const Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: CustomColors.backgroundColor,
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
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomWidgets.phoneNumberField(
            controller: _phoneController,
          ),
          const SizedBox(height: 10),
          DefaultTextField(
            title: "İsim Soyisim",
            controller: TextEditingController(
                text: '${profile.firstName} ${profile.lastName}'),
            hintText: '${profile.firstName} ${profile.lastName}',
          ),
          const SizedBox(height: 10),
          DefaultTextField(
            title: "İl",
            controller: TextEditingController(
                text: profile.addresses.isNotEmpty
                    ? profile.addresses.first
                    : ''),
            hintText:
                profile.addresses.isNotEmpty ? profile.addresses.first : '',
          ),
          const SizedBox(height: 10),
          DefaultTextField(
            title: "İlçe",
            controller: TextEditingController(
                text: profile.addresses.length > 1 ? profile.addresses[1] : ''),
            hintText: profile.addresses.length > 1 ? profile.addresses[1] : '',
          ),
          const SizedBox(height: 20),
          BrownButton(
            title: "Güncelle",
            onTap: _checkFields,
          ),
        ],
      ),
    );
  }

  void _checkFields() {
    Get.to(() => const ProfilePage());
  }
}
