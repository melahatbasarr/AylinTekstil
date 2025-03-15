import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/features/basket/model/basket_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrackOrderPage extends StatefulWidget {
  final BasketItem item;

  const TrackOrderPage({required this.item, super.key});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets.appBar("Track Order"),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildItemDetails(widget.item),
          const SizedBox(height: 20),
          CustomWidgets.customDivider(),
          const SizedBox(height: 15),
          CustomWidgets.settingBlackText("Order Details"),
          const SizedBox(height: 15),
          _buildOrderDetails(widget.item),
          const SizedBox(height: 15),
          CustomWidgets.customDivider(),
          const SizedBox(height: 15),
          CustomWidgets.settingBlackText("Order Status"),
          const SizedBox(height: 15),
          _buildOrderStatus(),
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
          child: Image.asset(item.image, fit: BoxFit.cover),
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
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '| ${item.quantity} Adet',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetails(BasketItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
          "Tahmini Teslim Tarihi",
          DateFormat('dd.MM.yyyy HH:mm').format(item.expectedDeliveryDate),
        ),
        const SizedBox(height: 10),
        _buildDetailRow("Takip Numarası", item.trackingId),
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

  Widget _buildOrderStatus() {
    final statusDates = {
      "Order Placed": DateTime(2024, 8, 1, 10, 30),
      "In Progress": DateTime(2024, 8, 2, 11, 00),
      "Shipped": DateTime(2024, 8, 3, 14, 45),
      "Delivered": DateTime(2024, 8, 4, 16, 00),
    };

    final statusImages = {
      "Order Placed": 'assets/images/order_image_1.png',
      "In Progress": 'assets/images/order_image_2.png',
      "Shipped": 'assets/images/order_image_3.png',
      "Delivered": 'assets/images/order_image_4.png',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var status in statusDates.keys) ...[
          _buildStatusStep(status, statusDates[status], statusImages[status]),
          if (status != statusDates.keys.last)
            _buildStatusConnector(statusDates[status] != null),
        ],
      ],
    );
  }

  Widget _buildStatusStep(String title, DateTime? date, String? imagePath) {
    final isActive = date != null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatusCircle(isActive),
        const SizedBox(width: 15),
        Expanded(
          child: Row(
            children: [
              
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    if (isActive)
                      Text(
                        DateFormat('dd.MM.yyyy HH:mm').format(date),
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                  ],
                ),
              ),
              if (imagePath != null)
                SizedBox(
                  width: 40, 
                  height: 40, 
                  child: Image.asset(imagePath),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusConnector(bool isActive) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: 4,
      height: 60,
      color: isActive ? const Color(0xFF3C5A5D) : Colors.grey[300],
    );
  }

  Widget _buildStatusCircle(bool isActive) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFFB77C4A) : Colors.grey[300],
      ),
      child: Center(
        child: isActive
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : null,
      ),
    );
  }
}
