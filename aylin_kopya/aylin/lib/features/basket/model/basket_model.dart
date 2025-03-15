import 'package:aylin/features/home/model/home_model.dart';

class BasketItem extends HomeModel {
  final String price;
  final String color;
  final String image;
  int quantity;
  DateTime orderDate;
  String totalPrice;
  String shippingCost;
  String vat;
  String deliveryAddress;
  String status;
  DateTime expectedDeliveryDate;
  String trackingId;
  final Map<String, DateTime>? statusDates;

  BasketItem({
    required String id,
    required String name,
    required this.price,
    required this.color,
    required this.image,
    required this.quantity,
    required this.orderDate,
    required this.totalPrice,
    required this.shippingCost,
    required this.vat,
    required this.deliveryAddress,
    required this.status,
    required this.expectedDeliveryDate,
    required this.trackingId,
    required this.statusDates,
    required Map<String, String> colorImages,
    required String amount,
    required String group,
    required String description,
    required List<String> availableColors,
    String selectedColor = "Red",
    bool isFavorited = false,
  }) : super(
          id: id,
          name: name,
          colorImages: colorImages,
          amount: amount,
          group: group,
          description: description,
          availableColors: availableColors,
          selectedColor: selectedColor,
          isFavorited: isFavorited,
        );
}
