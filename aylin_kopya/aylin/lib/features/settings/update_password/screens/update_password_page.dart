import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/common/widget/password_textfield.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/auth/forgot_password/screens/forgot_password_screen.dart';
import 'package:aylin/features/profile/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Şifre Güncelle"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PasswordTextField(
              title: "Şimdiki Şifreniz",
              controller: _currentPasswordController,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Şifremi Unuttum ',
                  style: const TextStyle(
                    color: CustomColors.color,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                ),
              ),
            ),
            const SizedBox(height: 15),
            PasswordTextField(
              title: "Yeni Şifreniz",
              controller: _newPasswordController,
            ),
            const SizedBox(height: 15),
            PasswordTextField(
              title: "Yeni Şifreniz Tekrar",
              controller: _confirmPasswordController,
            ),
            const Spacer(),
            BrownButton(
              title: "Güncelle",
              onTap: _checkFields,
            ),
          ],
        ),
      ),
    );
  }

  void _checkFields() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }
}
