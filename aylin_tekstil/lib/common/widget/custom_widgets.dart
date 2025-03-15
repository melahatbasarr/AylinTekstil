import 'package:aylin/common/widget/defeault_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:get/get.dart';

class CustomWidgets {

  static Text pageTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 21,
        fontFamily: "Inter",
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static Text settingBlackText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontFamily: "Inter",
      ),
    );
  }

  static Text expText(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: CustomColors.lightGreenText,
        fontFamily: "Inter",
        fontSize: 13,
      ),
    );
  }

  static Text expTextTwo(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: CustomColors.lightGreenText,
        fontFamily: "Inter",
        fontSize: 15,
      ),
    );
  }

  static Text greenText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: CustomColors.greenText,
        fontFamily: "Inter",
      ),
    );
  }

  static Text blackText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontFamily: "Inter",
      ),
    );
  }

  

  static AppBar appBar(String title, {bool? backButtonVisibility}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        padding: const EdgeInsets.only(top: 15),
        child: CustomWidgets.pageTitle(title),
      ),
      centerTitle: true,
      leading: Visibility(
        visible: backButtonVisibility ?? true,
        child: GestureDetector(
          onTap: () {
            final currentRoute = Get.currentRoute;
            if ([
              '/',
              '/categoriesPage',
              '/favoriesPage',
              '/basketPage',
              '/profilePage',
            ].contains(currentRoute)) {
              Get.offAllNamed('/homePage');
            } else {
              Get.back();
            }
          },
          child: Container(
            margin: const EdgeInsets.only(left: 10, top: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black.withOpacity(0.2),
                width: 1.0,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.arrow_back, color: Colors.black, size: 25),
          ),
        ),
      ),
    );
  }

  static showSnackBar({String? title, required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: CustomColors.color,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      ),
    );
  }

  static Divider customDivider({
    double thickness = 0.5,
    Color color = Colors.grey,
    double indent = 0.0,
    double endIndent = 0.0,
  }) {
    return Divider(
      color: color.withOpacity(0.5),
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }

  static Widget greyCircular({
    required double diameter,
    required Color color,
    double borderWidth = 1.0,
    required String imagePath,
  }) {
    return ClipOval(
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          color: color,
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: diameter * 0.6,
            height: diameter * 0.6,
          ),
        ),
      ),
    );
  }

  static Widget phoneNumberField({
    required TextEditingController controller,
    String title = "Telefon",
    String hintText = "+90",
  }) {
    return DefaultTextField(
      controller: controller,
      title: title,
      hintText: hintText,
      keyboardType: TextInputType.phone,
      inputFormatters: [PhoneNumberFormatter()],
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (newText.isNotEmpty && !newText.startsWith('90')) {
      newText = '90$newText';
    }

    newText = newText.length > 2 ? '+90 ${newText.substring(2)}' : '+90';

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
