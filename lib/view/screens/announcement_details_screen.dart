import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/custom_button_widget.dart';

import '../../theme/app_styles.dart';

class AnnouncementDetailsScreen extends StatefulWidget {
  const AnnouncementDetailsScreen({super.key});

  @override
  _AnnouncementDetailsScreenState createState() => _AnnouncementDetailsScreenState();
}

class _AnnouncementDetailsScreenState extends State<AnnouncementDetailsScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedUnit = 'kg';
  String _selectedType = 'Organic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Details',
          style: TextStyles.titleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: TextStyles.fieldStyle.copyWith(
                      fontWeight: FontWeight.w700
                    ),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyles.fieldStyle.copyWith(
                          fontWeight: FontWeight.w500
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: _selectedUnit,
                    decoration: InputDecoration(
                      labelText: 'Unit',
                      labelStyle: TextStyles.fieldStyle.copyWith(
                          fontWeight: FontWeight.w500
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnit = value!;
                      });
                    },
                    items: <String>['kg', 'g', 'lb', 'oz']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                          style: TextStyles.fieldStyle.copyWith(
                            fontWeight: FontWeight.w700
                        ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: InputDecoration(
                labelText: 'Type',
                labelStyle: TextStyles.fieldStyle.copyWith(
                    fontWeight: FontWeight.w500
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
              items: <String>['Organic', 'Non-Organic']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: TextStyles.fieldStyle.copyWith(
                      fontWeight: FontWeight.w700
                  ),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButtonWidget(
                onButtonPressed: () {
                  // Handle confirm action
                  print('Amount: ${_amountController.text} $_selectedUnit');
                  print('Type: $_selectedType');
                },
                text: 'Confirm',
                textColor: AppColors.buttonLoginTextColor,
                 backgroundColor: AppColors.buttonLoginBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}