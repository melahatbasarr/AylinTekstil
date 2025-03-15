import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // URL launcher için paket

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {"icon": 'assets/icons/headphones_icon.png', "text": "Müşteri Temsilcisi", "action": _callCustomerService},
      {"icon": 'assets/icons/whatsapp_icon.png', "text": "Whatsapp", "action": _openWhatsApp},
      {"icon": Icons.public, "text": "Websitemiz", "action": _openWebsite},
      {"icon": Icons.facebook, "text": "Facebook", "action": _openFacebook},
      {"icon": 'assets/icons/instagram_icon.png', "text": "İnstagram", "action": _openInstagram},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomWidgets.appBar("İletişime Geçin"),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2), 
                ),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: _buildLeadingIcon(item["icon"]),
              title: CustomWidgets.settingBlackText(item["text"]),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: CustomColors.color
              ),
              onTap: () => item["action"](),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLeadingIcon(dynamic icon) {
    if (icon is IconData) {
      return Icon(icon, color:CustomColors.color);
    } else if (icon is String) {
      return Image.asset(icon, width: 24, height: 24);
    }
    return const SizedBox.shrink();
  }

  void _callCustomerService() async {
    const phoneNumber = 'tel:+905399246901'; 
    // ignore: deprecated_member_use
    if (await canLaunch(phoneNumber)) {
      // ignore: deprecated_member_use
      await launch(phoneNumber);
    } else {
      throw 'Telefon numarası açılamıyor.';
    }
  }

  void _openWhatsApp() async {
    const whatsappUrl = 'https://wa.me/+905399246901';
    // ignore: deprecated_member_use
    if (await canLaunch(whatsappUrl)) {
      // ignore: deprecated_member_use
      await launch(whatsappUrl);
    } else {
      throw 'WhatsApp açılamıyor.';
    }
  }

  void _openWebsite() async {
    const url = 'https://www.aylintriko.com.tr/';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Web sitesi açılamıyor.';
    }
  }

  void _openFacebook() async {
    const url = 'https://www.facebook.com/aylintrikotoptan';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Facebook sayfası açılamıyor.';
    }
  }

  void _openInstagram() async {
    const url = 'https://www.instagram.com/aylintriko_toptan/'; 
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Instagram sayfası açılamıyor.';
    }
  }
}
