import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/features/basket/controller/basket_controller.dart';
import 'package:aylin/features/basket/model/basket_model.dart';
import 'package:aylin/features/basket/screen/basket_item_widget.dart';
import 'package:aylin/features/basket/screen/review_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final BasketController _basketController = Get.put(BasketController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPriceSummary();
    });

    _basketController.basketItems.listen((_) {
      _showPriceSummary();
    });
  }

  double _calculateTotal() {
    double total = 0.0;
    for (var item in _basketController.basketItems) {
      double price =
          double.tryParse(item.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
      total += price * item.quantity;
    }
    return total;
  }

  double _calculateVAT(double total) {
    return total * 0.18;
  }

  double _calculateGrandTotal(double total, double vat) {
    return total + vat;
  }

  void _showPriceSummary() {
    final total = _calculateTotal();
    final vat = _calculateVAT(total);
    final grandTotal = _calculateGrandTotal(total, vat);

    showModalBottomSheet(
      backgroundColor: CustomColors.textField,
      context: context,
      barrierColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomWidgets.settingBlackText("Ödeme Özeti"),
              const SizedBox(height: 20),
              _buildPriceSummary(total, vat, grandTotal),
              const SizedBox(height: 20),
              BrownButton(title: "Devam Et", onTap: _checkFields)
            ],
          ),
        );
      },
    );
  }

  Widget _buildPriceSummary(double total, double vat, double grandTotal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPriceDetail("Tutar:", total),
        _buildPriceDetail("KDV:", vat),
        _buildPriceDetail("Toplam:", grandTotal),
      ],
    );
  }

  Widget _buildPriceDetail(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomWidgets.greenText(label),
          Text(
            "${value.toStringAsFixed(2)} TL",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Sepetim"),
      body: Obx(
        () => Column(
          children: [
            _basketController.basketItems.isEmpty
                ? const Center(child: Text('Sepetiniz boş'))
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: ListView.builder(
                        itemCount: _basketController.basketItems.length,
                        itemBuilder: (context, index) {
                          final item = _basketController.basketItems[index];
                          return Dismissible(
                            key: Key(item.id.toString()),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              return await _showDeleteConfirmation(
                                  context, index);
                            },
                            background: _buildDismissBackground(),
                            child: BasketItemWidget(
                              item: item,
                              onIncrease: () =>
                                  _basketController.increaseQuantity(index),
                              onDecrease: () =>
                                  _basketController.decreaseQuantity(index),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      color: CustomColors.color,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context, int index) async {
    final item = _basketController.basketItems[index];

    return showModalBottomSheet<bool>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return _buildDeleteConfirmationSheet(context, item, index);
      },
    );
  }

  Widget _buildDeleteConfirmationSheet(
    BuildContext context,
    BasketItem item,
    int index,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomWidgets.settingBlackText("Ürünü Sepetten Kaldır"),
          const SizedBox(height: 20),
          _buildItemDetails(item),
          const SizedBox(height: 20),
          _buildConfirmationButtons(context, item, index),
        ],
      ),
    );
  }

  Widget _buildItemDetails(BasketItem item) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(
            item.image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomWidgets.blackText(item.name),
              const SizedBox(height: 8),
              CustomWidgets.expText(item.color),
              Text(
                item.price,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmationButtons(
    BuildContext context,
    BasketItem item,
    int index,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.textField,
            padding: const EdgeInsets.symmetric(
              horizontal: 70,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(
            'İptal',
            style: TextStyle(color: CustomColors.color),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _basketController.removeItem(index);
            Navigator.of(context).pop(true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${item.name} sepetinizden silindi."),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.color,
            padding: const EdgeInsets.symmetric(
              horizontal: 70,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text('Evet'),
        ),
      ],
    );
  }

  void _checkFields() {
    if (_basketController.basketItems.isNotEmpty) {
      _basketController.setSelectedItem(_basketController.basketItems[0]);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewSummaryPage(
            items: _basketController.basketItems,
          ),
        ),
      );
    } else {
      CustomWidgets.showSnackBar(message: 'Sepetinizde ürün bulunmuyor.');
    }
  }
}
