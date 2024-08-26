import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/custom_button_widget.dart';
import '../../theme/app_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementDetailsScreen extends StatefulWidget {
  final String restaurantName;

  const AnnouncementDetailsScreen({Key? key, required this.restaurantName}) : super(key: key);

  @override
  _AnnouncementDetailsScreenState createState() => _AnnouncementDetailsScreenState();
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
      'restaurantName': widget.restaurantName,  // Use widget.restaurantName
      'location': '123 Main St', 
      'quantity': quantityAsInt,
      'unit': _selectedUnit,
      'type': _selectedType,
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
          style: TextStyles.titleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Restaurant: ${widget.restaurantName}', // Display the restaurant name
              style: TextStyles.fieldStyle.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    style: TextStyles.fieldStyle.copyWith(fontWeight: FontWeight.w700),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyles.fieldStyle.copyWith(fontWeight: FontWeight.w500),
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
                      labelStyle: TextStyles.fieldStyle.copyWith(fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedUnit = value!;
                      });
                    },
                    items: <String>['kg', 'g', 'lb', 'oz'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyles.fieldStyle.copyWith(fontWeight: FontWeight.w700),
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
                labelStyle: TextStyles.fieldStyle.copyWith(fontWeight: FontWeight.w500),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
              items: <String>['Organic', 'Non-Organic'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyles.fieldStyle.copyWith(fontWeight: FontWeight.w700),
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
