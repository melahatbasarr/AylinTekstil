import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/common/widget/defeault_textfield.dart';
import 'package:aylin/features/profile/profile/profile_page.dart';
import 'package:flutter/material.dart';

class AccountDeletionPage extends StatelessWidget {
  const AccountDeletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _accountDeletionController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Hesap Silme İsteği"),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ListView(
                children: [
                  DefaultTextField(
                      title: "Hesabınızı Neden Siliyorsunuz",
                      controller: _accountDeletionController,
                      hintText:
                          "Lütfen hesabınızı neden sildiğinizi açıklayınız ...",
                      maxLines: 8),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BrownButton(
              title: "Silme Talebini Gönder",
              onTap: () => _checkFields(context),
            ),
          ),
        ],
      ),
    );
  }

  void _checkFields(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }
}
