import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/order_card_widget.dart';

import '../../theme/app_styles.dart';

class DriversOrdersWidget extends StatelessWidget {
  const DriversOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Announcements',
          style: TextStyles.titleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView(
                children: [
                  _buildOrderCard(
                    context,
                    'Restaurant A',
                    '123 Main St',
                    5,
                  ),
                  _buildOrderCard(
                    context,
                    'Restaurant B',
                    '456 Elm St',
                    3,
                  ),
                  _buildOrderCard(
                    context,
                    'Hotel C',
                    '789 Maple Ave',
                    7,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(
      BuildContext context, String restaurantName, String location, int quantity) {
    return OrderCardWidget(
        restaurantName: restaurantName,
        location: location,
        quantity: quantity,
        onAccept: (){},
        onReject: (){}
    );
  }
}
