import 'package:aylin/common/widget/circular_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/auth/login/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

final class _OnBoardingPageState extends State<OnBoardingPage> {
  final List<String> titles = [
    "Ürünleri Görüntüleyin",
    "Ürünleri Görüntüleyin",
    "Ürünleri Görüntüleyin"
  ];
  final List<String> contents = [
    "Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt",
    "Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt",
    "Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt"
  ];
  final PageController pageController = PageController();
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: titles.length,
            itemBuilder: (context, index) => _buildPageContent(index),
            onPageChanged: (index) => setState(() => selectedPageIndex = index),
          ),
          _buildNextButton(),
          _buildSkipButton(context),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildPageContent(int index) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
        physics: const BouncingScrollPhysics(),
        children: [
          Container(color: Colors.white, height: 450),
          const SizedBox(height: 30),
          Text(titles[index],
              style: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w600,
                  fontSize: 26),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text(contents[index],
              style: const TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  color: CustomColors.lightGreenText),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Positioned(
      right: 25,
      bottom: 65,
      child: CircularButton(
        onTap: () async {
          if (selectedPageIndex < titles.length - 1) {
            pageController.animateToPage(
              selectedPageIndex + 1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear,
            );
          } else {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            await sharedPreferences.setBool("isOnBoardingSeen", true);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          }
        },
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return Positioned(
      top: 40,
      right: 8,
      child: TextButton(
        onPressed: () async {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setBool("isOnBoardingSeen", true);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) =>const LoginPage()),
            (route) => false,
          );
        },
        child: CustomWidgets.greenText("Skip"),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Positioned(
      right: 180,
      bottom: 85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          titles.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: selectedPageIndex == index ? 12 : 10,
            height: selectedPageIndex == index ? 12 : 9,
            decoration: BoxDecoration(
              color: selectedPageIndex == index
                  ? CustomColors.color
                  : CustomColors.textField,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
