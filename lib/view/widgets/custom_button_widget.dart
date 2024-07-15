import 'package:flutter/material.dart';
import 'package:foodforgood/theme/app_styles.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onButtonPressed;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.onButtonPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor ?? AppColors.buttonBackgroundColor),
      ),
      onPressed: onButtonPressed,
      child: Text(
        text,
        style: TextStyles.buttonTextStyle.copyWith(color: textColor ?? AppColors.buttonTextColor),
      ),
    );
  }
}
