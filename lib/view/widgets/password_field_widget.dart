import 'package:flutter/material.dart';

import '../../theme/app_styles.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final Function(String)? onChanged;

  const PasswordFieldWidget({super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
  });

  @override
  PasswordFieldWidgetState createState() => PasswordFieldWidgetState();
}

class PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool _obscureText = true;
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
      obscureText: _obscureText,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        errorText: widget.errorText,
        hintText: "Enter your password",
        hintStyle: TextStyles.fieldStyle.copyWith(color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: _focusNode.hasFocus ? Colors.blue : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      style: TextStyles.fieldStyle.copyWith(color: Colors.white),
    );
  }
}