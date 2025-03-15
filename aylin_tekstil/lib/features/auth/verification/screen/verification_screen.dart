import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/auth/forgot_password/screens/forgot_password_screen.dart';
import 'package:aylin/features/auth/verification/controller/verification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});
  
  final VerificationController controller = Get.put(VerificationController(Get.find()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Doğrulama"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          children: [
            CustomWidgets.pageTitle("Doğrulama Kodu"),
            const SizedBox(height: 10),
            CustomWidgets.expText("Telefon numaranıza gönderilen 4 haneli \n doğrulama kodunu giriniz."),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return _buildCodeInputField(index);
              }),
            ),
            const SizedBox(height: 30),
            CustomWidgets.expText("Kodu Almadınız mı?"),
            const SizedBox(height: 5),
            CustomWidgets.blackText("Tekrar Gönderin"),
            const SizedBox(height: 25),
            BrownButton(title: "Doğrula", onTap: () => _checkFields(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeInputField(int index) {
    return SizedBox(
      width: 57,
      height: 41.28,
      child: TextField(
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 3) {
              FocusScope.of(Get.context!).nextFocus();
            } else {
              FocusScope.of(Get.context!).unfocus();
            }
          }
          final code = controller.verificationCode.value.code.split('');
          if (index >= 0 && index < code.length) {
            code[index] = value;
            controller.setCode(code.join());
          } else {
         
            print('Hatalı indeks: $index');
          }
        },
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: CustomColors.textField,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }

  void _checkFields(BuildContext context) async {
    final phoneNumber = "User's phone number"; 

    await controller.verifyCode(phoneNumber: phoneNumber);
    if (!controller.isLoading.value) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
      );
    }
  }
}
