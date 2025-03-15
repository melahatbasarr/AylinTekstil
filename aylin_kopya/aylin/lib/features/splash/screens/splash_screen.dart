import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/auth/login/screens/login_page.dart';
import 'package:aylin/features/navigator/screens/navigator_page.dart';
import 'package:aylin/features/onboarding/onboarding_page.dart';
import 'package:aylin/features/splash/controller/splash_controller.dart';
import 'package:aylin/features/splash/repository/splash_repository.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SplashDelegate {
  final SplashController _controller = SplashController(SplashRepositoryImpl());


  @override
  void initState() {
    super.initState();
    _controller.delegate = this;
    _controller.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Image.asset(
              'assets/images/ellipse_2.png',
            ),
          ),
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 222,
              height: 75,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/ellipse_1.png',
            ),
          ),
        ],
      ),
    );
  }

  @override
  void notify(SplashResults result) {
    switch (result) {
      case SplashResults.login:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
        break;
      case SplashResults.onBoarding:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingPage()),
            (route) => false);
        break;
      case SplashResults.navigator:
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => NavigatorPage()),
            (route) => false);
        break;
    }
  }
}
