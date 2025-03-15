import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/common/widget/defeault_textfield.dart';
import 'package:aylin/common/widget/password_textfield.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/auth/forgot_password/screens/forgot_password_screen.dart';
import 'package:aylin/features/auth/login/repository/login_repository.dart';
import 'package:aylin/features/auth/register/screens/register_page.dart';
import 'package:aylin/features/navigator/screens/navigator_page.dart';
import 'package:aylin/features/auth/login/controller/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginDelegate {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
    final LoginController _loginController = LoginController(LoginRepositoryImpl());


  @override
  void initState() {
    super.initState();
    _loginController.delegate = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 150),
        physics: const BouncingScrollPhysics(),
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                CustomWidgets.pageTitle("Giriş Yap"),
                const SizedBox(height: 20),
                CustomWidgets.expText("Aylin Triko'ya Hoşgeldiniz!"),
              ],
            ),
          ),
          const SizedBox(height: 40),
          DefaultTextField(title: "E-posta", controller: _emailController),
          const SizedBox(height: 15),
          PasswordTextField(title: "Şifre", controller: _passwordController),
          _buildForgotPasswordText(),
          const SizedBox(height: 15),
          BrownButton(title: "Giriş Yap", onTap: _checkFields),
          const SizedBox(height: 35),
          _buildRegisterText(),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordText() {
    return Align(
      alignment: Alignment.centerRight,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen())),
        child: const Text(
          'Şifremi Unuttum? ',
          style: TextStyle(
            fontSize: 14,
            color: CustomColors.greenText,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Hesabınız yok mu? ',
          style: const TextStyle(
              color: Colors.black,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400),
          children: [
            TextSpan(
              text: 'Kaydolun',
              style: const TextStyle(
                color: CustomColors.greenText,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage())),
            ),
          ],
        ),
      ),
    );
  }

  void _checkFields() {
  final email = _emailController.text.trim();
  final password = _passwordController.text.trim();

  _loginController.loginUser(
    email: email,
    password: password,
  );
}


  @override
void notify(isSuccess) {
  if (isSuccess) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavigatorPage()),
    );
  } else {
    showSnackBar(
      title: 'Giriş Başarısız',
      message: 'E-posta veya şifre geçersiz.',
    );
  }
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
}
