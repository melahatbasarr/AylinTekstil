import 'package:aylin/features/addresses/update_address/controller/update_address_controller.dart';
import 'package:aylin/features/auth/forgot_password/repository/forgot_password_repository.dart';
import 'package:aylin/features/auth/register/controller/register_controller.dart';
import 'package:aylin/features/auth/register/repository/register_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aylin/features/profile/profile/controller/profile_controller.dart';
import 'package:aylin/features/addresses/addresses/controller/addresses_contoller.dart';
import 'package:aylin/features/basket/controller/basket_controller.dart';
import 'package:aylin/features/onboarding/onboarding_page.dart';
import 'package:aylin/config/routes/routes.dart';

void main() {
  final registerRepository = RegisterRepositoryImpl();
  Get.put(RegisterController(registerRepository));
  Get.put(ProfileController());
  Get.put(AddressController());
  Get.put(BasketController());
  Get.put(UpdateAddressController());
  Get.put<ForgotPasswordRepository>(ForgotPasswordRepositoryImpl());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
      title: 'Aylin',
      theme: ThemeData(
        fontFamily: "Inter",
      ),
      home: const OnBoardingPage(),
    );
  }
}
