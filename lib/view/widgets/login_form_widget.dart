import 'package:flutter/material.dart';
import 'package:foodforgood/theme/app_styles.dart';
import 'package:foodforgood/view/widgets/custom_text_field_widget.dart';
import 'package:foodforgood/view/widgets/password_field_widget.dart';
import 'custom_button_widget.dart';

class LoginFormWidget extends StatefulWidget {
  final VoidCallback onLoginPressed;

  const LoginFormWidget({required this.onLoginPressed, super.key});

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
  }

  void _validateEmail() {
    setState(() {
      _emailError = _validateEmailText(_emailController.text);
    });
  }

  void _validatePassword() {
    setState(() {
      _passwordError = _validatePasswordText(_passwordController.text);
    });
  }

  String? _validateEmailText(String email) {
    if (email.isEmpty) {
      return "Email cannot be empty";
    }
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validatePasswordText(String password) {
    if (password.isEmpty) {
      return "Password cannot be empty";
    }
    if (password.length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CustomLabelText("E-mail"),
        const SizedBox(height: 8),
        CustomTextFieldWidget(
          controller: _emailController,
          hintText: "Enter your email",
          errorText: _emailError,
          onChanged: (text) {
            _validateEmail();
          },
        ),
        const SizedBox(height: 16),
        const _CustomLabelText("Password"),
        const SizedBox(height: 8),
        PasswordFieldWidget(
          controller: _passwordController,
          errorText: _passwordError,
          onChanged: (text) {
            _validatePassword();
          },
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              // Handle forget password logic
            },
            child: Text(
              "Forget password?",
              style: TextStyles.normalStyle.copyWith(color: AppColors.forgetPasswordColor),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: CustomButtonWidget(
            text: 'Login',
            onButtonPressed: () {
              _validateEmail();
              _validatePassword();
              if (_emailError == null && _passwordError == null) {
                widget.onLoginPressed();
              }
            },
            backgroundColor: AppColors.buttonLoginBackgroundColor,
            textColor: AppColors.buttonLoginTextColor,
          ),
        ),
      ],
    );
  }
}

class _CustomLabelText extends StatelessWidget {
  final String text;

  const _CustomLabelText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyles.subtitleStyle.copyWith(color: AppColors.subtitleColor)
    );
  }
}
