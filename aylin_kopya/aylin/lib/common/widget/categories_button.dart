import 'package:aylin/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CategoriesButton extends StatelessWidget {
  final Function() onTap;
  final Color color;
  final Widget child; 
  final String text;

  const CategoriesButton({
    super.key,
    required this.onTap,
    this.color = CustomColors.textField,
    required this.child,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 55, 
            height: 55,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: child,
          ),
          const SizedBox(height: 8.0),
          Text(
            text, 
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
