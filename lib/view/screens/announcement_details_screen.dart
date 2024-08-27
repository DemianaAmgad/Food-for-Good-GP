import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/custom_button_widget.dart';
import '../../theme/app_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementDetailsScreen extends StatefulWidget {
  final String restaurantName;

  const AnnouncementDetailsScreen({super.key, required this.restaurantName});

  @override
  _AnnouncementDetailsScreenState createState() =>
      _AnnouncementDetailsScreenState();
}

class _AnnouncementDetailsScreenState extends State<AnnouncementDetailsScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedUnit = 'kg';
  String _selectedType = 'Organic';

  Future<void> _submitAnnouncement() async {
    final firestore = FirebaseFirestore.instance;
    final quantity = double.tryParse(_amountController.text) ?? 0;
    final quantityAsInt = quantity.toInt();

    await firestore.collection('announcements').add({
      'restaurantName': widget.restaurantName,
      'location': '123 Main St',
      'quantity': quantityAsInt,
      'unit': _selectedUnit,
      'type': _selectedType,
      'pickedUp': false,
      'delivered': false,
      'acceptedBy': null,
      'rejectedBy': [],
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Announcement added successfully')),
      );
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add announcement: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Details',
          style: TextStyles.titleStyle.copyWith(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: AppColors.buttonAcceptBackgroundColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restaurant: ${widget.restaurantName}',
              style: TextStyles.fieldStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: TextStyles.fieldStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyles.fieldStyle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
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
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
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
                        child: Text(
                          value,
                          style: TextStyles.fieldStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: InputDecoration(
                labelText: 'Type',
                labelStyle: TextStyles.fieldStyle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
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
                  child: Text(
                    value,
                    style: TextStyles.fieldStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.0,
                    ),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButtonWidget(
                onButtonPressed: _submitAnnouncement,
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
