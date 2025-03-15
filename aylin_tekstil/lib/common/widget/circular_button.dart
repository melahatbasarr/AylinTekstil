import 'package:aylin/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  
  final Function() onTap;

  const CircularButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 55, 
        height: 55,
        decoration:const BoxDecoration(
          color: CustomColors.color,
          shape: BoxShape.circle, 
        ),
        alignment: Alignment.center,
        child:const Icon(Icons.arrow_forward_rounded, color: Colors.white),
      ),
    );
  }
}

