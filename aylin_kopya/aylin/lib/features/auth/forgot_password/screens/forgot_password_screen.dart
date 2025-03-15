import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/common/widget/password_textfield.dart';
import 'package:aylin/features/navigator/screens/navigator_page.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar(""),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    CustomWidgets.pageTitle("Şifre Sıfırlama"),
                    const SizedBox(height: 10),
                    CustomWidgets.expText("Lütfen yeni şifrenizi giriniz."),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              PasswordTextField(
                title: "Yeni Şifre",
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre boş bırakılamaz.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 13),
              PasswordTextField(
                title: "Yeni Şifre Tekrar",
                controller: _newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Şifre tekrar boş bırakılamaz.';
                  }
                  if (value != _passwordController.text) {
                    return 'Şifreler eşleşmiyor.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 35),
              BrownButton(
                title: "Kaydet",
                onTap: _checkFields,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _checkFields() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigatorPage()),
      );
    }
  }
}
