import 'package:flutter/material.dart';
import 'package:foodforgood/theme/app_styles.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final Function(String)? onChanged;
  final Color? hintColor;
  final Color? textColor;

  const CustomTextFieldWidget({super.key,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.onChanged, this.hintColor, this.textColor,
  });

  @override
  CustomTextFieldWidgetState createState() => CustomTextFieldWidgetState();
}

class CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        errorText: widget.errorText,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: BorderSide(
        //     color: widget.errorText != null ? Colors.red : Colors.grey,
        //   ),
        // ),
        hintText: widget.hintText,
        hintStyle: TextStyles.fieldStyle.copyWith(color: widget.hintColor?? Colors.grey),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: BorderSide(
        //     color: widget.errorText != null ? Colors.red : Colors.blue,
        //   ),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: BorderSide(
        //     color: widget.errorText != null ? Colors.red : Colors.grey,
        //   ),
        // ),
      ),
      style: TextStyles.fieldStyle.copyWith(color: widget.textColor?? Colors.white),
    );
  }
}