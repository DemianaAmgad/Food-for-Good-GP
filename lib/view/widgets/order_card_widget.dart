import 'package:flutter/material.dart';

import '../../theme/app_styles.dart';

class OrderCardWidget extends StatelessWidget {
  final String restaurantName;
  final String location;
  final int quantity;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const OrderCardWidget({
    super.key,
    required this.restaurantName,
    required this.location,
    required this.quantity,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackgroundColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              restaurantName,
              style: TextStyles.cardTitleStyle.copyWith(
                  color: AppColors.cardTitleColor
              )
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.location_on, size: 18.0, color: AppColors.cardTextColor,),
                const SizedBox(width: 8.0),
                Text(location,
                  style: TextStyles.normalStyle.copyWith(color: AppColors.cardTextColor)
                  ,),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.shopping_cart, size: 18.0, color: AppColors.cardTextColor,),
                const SizedBox(width: 8.0),
                Text('Quantity: $quantity',
                    style: TextStyles.normalStyle.copyWith(color: AppColors.cardTextColor)
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonAcceptBackgroundColor,
                  ),
                  child: Text('Accept',
                    style: TextStyles.cardButtonTextStyle.copyWith(
                      color: AppColors.cardTitleColor
                    ),),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonRejectBackgroundColor,
                  ),
                  child: Text('Reject',
                    style: TextStyles.cardButtonTextStyle.copyWith(
                        color: AppColors.cardTitleColor
                    ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
