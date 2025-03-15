import 'package:flutter/material.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/features/basket/model/basket_model.dart';

class BasketItemWidget extends StatelessWidget {
  final BasketItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const BasketItemWidget({
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
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
                const SizedBox(height: 8),
                _buildQuantityControl(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(
            Icons.remove_circle,
            size: 30,
            color: CustomColors.backgroundColor,
          ),
          onPressed: onDecrease,
        ),
        Text(
          '${item.quantity}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.add_circle,
            size: 30,
            color: CustomColors.color,
          ),
          onPressed: onIncrease,
        ),
      ],
    );
  }
}
