import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/features/basket/screen/basket_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widget/brown_button.dart';
import '../../basket/controller/basket_controller.dart';
import '../../basket/model/basket_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeModel = Get.arguments;
    final BasketController basketController = Get.find();

    RxString selectedColor = RxString(HomeModel.selectedColor);

    return Scaffold(
      backgroundColor:Colors.white,
      appBar: CustomWidgets.appBar("Ürün Detay"),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _buildProductImage(HomeModel, selectedColor),
                const SizedBox(height: 20),
                _buildColorSelector(HomeModel, selectedColor),
                const SizedBox(height: 30),
                _buildProductName(HomeModel),
                const SizedBox(height: 20),
                _buildProductDescription(HomeModel),
                const SizedBox(height: 5),
                CustomWidgets.customDivider(),
                const SizedBox(height: 5),
                _buildSelectedColorDisplay(selectedColor),
                const SizedBox(height: 5),
                _buildColorOptions(selectedColor),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomWidgets.settingBlackText("Toplam:"),
                      CustomWidgets.expTextTwo(HomeModel.amount),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BrownButton(
                    title: "Sepete Ekle",
                    onTap: () {
                      basketController.addToBasket(
                        BasketItem(
                          id: HomeModel.id,
                          name: HomeModel.name,
                          price: (HomeModel.amount) ?? 0.0,
                          color: selectedColor.value,
                          image: HomeModel.colorImages[selectedColor.value] ?? '',
                          quantity: 1,
                          orderDate: DateTime.now(),
                          totalPrice: (HomeModel.amount) ?? 0.0,
                          shippingCost: 0.0.toString(),
                          vat: 0.0.toString(),
                          deliveryAddress: "",
                          status: "Not Started",
                          expectedDeliveryDate:
                              DateTime.now().add(const Duration(days: 7)),
                          trackingId: "",
                          statusDates: {},
                          colorImages: HomeModel.colorImages,
                          amount: HomeModel.amount,
                          group: HomeModel.group,
                          description: HomeModel.description,
                          availableColors: HomeModel.availableColors,
                          selectedColor: selectedColor.value,
                          isFavorited: HomeModel.isFavorited,
                        ),
                      );
                      Get.to(() => const BasketPage());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(dynamic HomeModel, RxString selectedColor) {
    return Center(
      child: Obx(() {
        return SizedBox(
          height: 200,
          width: MediaQuery.of(Get.context!).size.width * 0.6,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              HomeModel.colorImages[selectedColor.value] ?? '',
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProductName(dynamic HomeModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets.settingBlackText(HomeModel.name),
          const SizedBox(height: 8),
          CustomWidgets.expTextTwo(HomeModel.group),
        ],
      ),
    );
  }

  Widget _buildProductDescription(dynamic HomeModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomWidgets.settingBlackText("Ürün Açıklamaları"),
          const SizedBox(height: 8),
          CustomWidgets.expTextTwo(HomeModel.description),
        ],
      ),
    );
  }

  Widget _buildColorSelector(dynamic HomeModel, RxString selectedColor) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: HomeModel.colorImages.length,
        itemBuilder: (context, index) {
          String imagePath = HomeModel.colorImages.values.elementAt(index);
          String colorKey = HomeModel.colorImages.keys.elementAt(index);

          return GestureDetector(
            onTap: () {
              selectedColor.value = colorKey;
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildColorOptions(RxString selectedColor) {
    List<Color> colors = [
      Colors.red,
      Colors.lightGreen,
      Colors.blueGrey,
      Colors.deepPurple,
      Colors.yellow,
      Colors.black,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: colors.map((color) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  selectedColor.value = colorToString(color);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Obx(() {
                      if (colorToString(color) == selectedColor.value) {
                        return Container(
                          width: 15,
                          height: 15,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSelectedColorDisplay(RxString selectedColor) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            CustomWidgets.settingBlackText('Seçilen Renk :  '),
            CustomWidgets.expTextTwo(selectedColor.value),
          ],
        ),
      );
    });
  }

  String colorToString(Color color) {
    if (color == Colors.red) return 'Kırmızı';
    if (color == Colors.lightGreen) return 'Yeşil';
    if (color == Colors.blueGrey) return 'Mavi';
    if (color == Colors.deepPurple) return 'Mor';
    if (color == Colors.yellow) return 'Sarı';
    if (color == Colors.black) return 'Siyah';
    return 'unknown';
  }
}
