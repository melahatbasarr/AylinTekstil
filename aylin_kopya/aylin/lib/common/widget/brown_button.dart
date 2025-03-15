import 'package:aylin/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';

final class BrownButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  const BrownButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 48,
        ),
        decoration:  BoxDecoration(
          color: CustomColors.color,
          borderRadius:BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child:Text(
          title,
          style:const TextStyle(
            fontSize: 18,
            fontFamily: 'Inter',
            color:Colors.white,
          )
        )
      ),
    );
  }
}
