import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/common/widget/defeault_textfield.dart';
import 'package:aylin/common/widget/password_textfield.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/auth/login/screens/login_page.dart';
import 'package:aylin/features/auth/register/controller/register_controller.dart';
import 'package:aylin/features/auth/verification/screen/verification_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _taxNumberController = TextEditingController();
  final TextEditingController _taxOfficeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _authorizedNameController =
      TextEditingController();

  bool _isPrivacyAccepted = false;

  final RegisterController _controller = Get.find();

  void _togglePrivacyAcceptance(bool? value) {
    setState(() {
      _isPrivacyAccepted = value ?? false;
    });
  }

  Future<void> _register() async {
    if (_isPrivacyAccepted) {
      try {
        
        await _controller.registerUser(
          companyName: _companyNameController.text,
          taxNumber: _taxNumberController.text,
          taxOffice: _taxOfficeController.text,
          city: _cityController.text,
          district: _districtController.text,
          address: _addressController.text,
          name: _authorizedNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerificationScreen()),
        );
      } catch (e) {}
    } else {
      CustomWidgets.showSnackBar(
          message: "Lütfen gizlilik sözleşmesini onaylayınız.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 70),
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildDescription(),
          const SizedBox(height: 13),
          _buildFormFields(),
          const SizedBox(height: 13),
          _buildPrivacyCheckbox(),
          const SizedBox(height: 13),
          _buildRegisterButton(),
          _buildRegisterText(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Align(
      alignment: Alignment.center,
      child: CustomWidgets.pageTitle("Kaydol"),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomWidgets.expText(
        "Sisteme kaydolmak ve Aylin Triko'nun avantaj dolu ürünlerini keşfetmek için bilgileri eksiksiz doldurarak kayıt olabilirsiniz.",
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        _buildTextField("Şirket Ünvanı", controller: _companyNameController),
        const SizedBox(height: 13),
        Row(
          children: [
            Expanded(
              child: _buildTextField("Vergi No / TC",
                  controller: _taxNumberController,
                  keyboardType: TextInputType.number),
            ),
            const SizedBox(width: 15),
            Expanded(
                child: _buildTextField("Vergi Dairesi",
                    controller: _taxOfficeController)),
          ],
        ),
        const SizedBox(height: 13),
        Row(
          children: [
            Expanded(
                child:
                    _buildTextField("İl Seçiniz", controller: _cityController)),
            const SizedBox(width: 15),
            Expanded(
                child: _buildTextField("İlçe Seçiniz",
                    controller: _districtController)),
          ],
        ),
        const SizedBox(height: 13),
        _buildTextField("Açık Adres", controller: _addressController),
        const SizedBox(height: 13),
        _buildTextField("Yetkili Ad Soyad",
            controller: _authorizedNameController),
        const SizedBox(height: 13),
        _buildTextField("E-Posta", controller: _emailController),
        const SizedBox(height: 13),
        _buildTextField("Telefon",
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
        const SizedBox(height: 13),
        PasswordTextField(title: "Şifre", controller: _passwordController),
      ],
    );
  }

  Widget _buildPrivacyCheckbox() {
    return Row(
      children: [
        Checkbox(
          activeColor: CustomColors.color,
          value: _isPrivacyAccepted,
          onChanged: _togglePrivacyAcceptance,
        ),
        const Expanded(
          child: Row(
            children: [
              Text("Gizlilik Sözleşmesini ",
                  style: TextStyle(
                      color: CustomColors.color,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                      fontFamily: "Inter")),
              Text("onaylıyorum.", style: TextStyle(fontFamily: "Inter")),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return BrownButton(
      title: "Kayıt Ol",
      onTap: _register,
    );
  }

  Widget _buildRegisterText() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Zaten hesabınız var mı? ',
          style: const TextStyle(
              color: Colors.black, fontFamily: "Inter", fontSize: 13),
          children: [
            TextSpan(
              text: 'Giriş Yapın',
              style: const TextStyle(
                color: CustomColors.greenText,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                fontFamily: "Inter",
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String title,
      {required TextEditingController controller,
      TextInputType keyboardType = TextInputType.text,
      List<TextInputFormatter>? inputFormatters}) {
    return DefaultTextField(
      title: title,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
    );
  }
}
