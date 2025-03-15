import 'package:aylin/common/widget/brown_button.dart';
import 'package:aylin/features/addresses/addresses/model/addresses_model.dart';
import 'package:aylin/features/addresses/address_selection/screen/address_selection.dart';
import 'package:aylin/features/profile/my_orders/screens/successful_order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/features/basket/model/basket_model.dart';
import 'package:aylin/features/addresses/addresses/controller/addresses_contoller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReviewSummaryPage extends StatelessWidget {
  final List<BasketItem> items;
  final Address? selectedAddress;

  ReviewSummaryPage({
    required this.items,
    this.selectedAddress,
    super.key,
  });

  final AddressController addressController = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    final deliveryAddress =
        selectedAddress?.fullAddress ?? addressController.getDefaultAddress();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Review Summary"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index < items.length) {
                  return _buildItemDetails(items[index]);
                } else if (index == items.length) {
                  return _buildOrderDetails();
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          _buildDeliveryAddressCard(context, deliveryAddress),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: BrownButton(
                title: "Onayla",
                onTap: () => _checkFields(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemDetails(BasketItem item) {
    return Column(
      children: [
        Row(
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
                  Row(
                    children: [
                      Text(
                        item.price,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '| ${item.quantity} Adet',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildOrderDetails() {
  final totalPrice = items.fold(0.0, (sum, item) {
    
    final priceStr = item.price.replaceAll(',', '.'); 
    final price = double.tryParse(priceStr) ?? 0.0; 
    return sum + price * item.quantity;
  });
  //bunları sonraısnda diğer sayfadan çekince düzelt
  final shippingCost = 10.0;
  final vat = totalPrice * 0.18;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildDetailRow("Sipariş Tarihi", DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now())),
      const SizedBox(height: 30),
      _buildDetailRow("Tutar", "${totalPrice.toStringAsFixed(2)} TL"), 
      const SizedBox(height: 30),
      _buildDetailRow("Kargo Ücreti", "${shippingCost.toStringAsFixed(2)} TL"),
      const SizedBox(height: 30),
      _buildDetailRow("KDV", "${vat.toStringAsFixed(2)} TL"),
    ],
  );
}


  Widget _buildDetailRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomWidgets.greenText(title),
        CustomWidgets.blackText(value),
      ],
    );
  }

  Widget _buildDeliveryAddressCard(BuildContext context, String address) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 0,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomWidgets.settingBlackText("Teslimat Adresi"),
                const SizedBox(height: 15),
                CustomWidgets.blackText(address),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _navigateToAddressSelectionPage(context),
              child: CustomWidgets.greenText("Değiştir"),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToAddressSelectionPage(BuildContext context) async {
    final selectedAddress = await Navigator.push<Address>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddressSelectionPage(),
      ),
    );

    if (selectedAddress != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewSummaryPage(
            items: items,
            selectedAddress: selectedAddress,
          ),
        ),
      );
    }
  }

  void _checkFields(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SuccessfulOrderPage()),
    );
  }
}
