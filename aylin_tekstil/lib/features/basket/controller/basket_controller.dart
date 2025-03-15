import 'package:get/get.dart';
import '../model/basket_model.dart';

class BasketController extends GetxController {
  final RxList<BasketItem> basketItems = <BasketItem>[].obs;
  final Rx<BasketItem?> selectedItem = Rx<BasketItem?>(null);

  void addToBasket(BasketItem item) {
    final index =
        basketItems.indexWhere((existingItem) => existingItem.id == item.id);
    if (index != -1) {
      basketItems[index].quantity += item.quantity;
    } else {
      basketItems.add(item);
    }
  }

  void removeFromBasket(BasketItem item) {
    basketItems.remove(item);
  }

  int get basketItemCount => basketItems.length;

  void setSelectedItem(BasketItem item) {
    selectedItem.value = item;
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < basketItems.length) {
      basketItems[index].quantity++;
      basketItems.refresh();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < basketItems.length) {
      if (basketItems[index].quantity > 1) {
        basketItems[index].quantity--;
        basketItems.refresh();
      } else {
        removeItem(index);
      }
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < basketItems.length) {
      basketItems.removeAt(index);
    }
  }
}
