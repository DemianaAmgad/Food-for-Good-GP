// signup_form_widget.dart
import 'package:flutter/material.dart';
import 'package:foodforgood/view/widgets/custom_text_field_widget.dart';
import 'package:foodforgood/view/widgets/password_field_widget.dart';
import 'package:foodforgood/view/widgets/custom_button_widget.dart';
import '../../theme/app_styles.dart';
import 'package:foodforgood/view/widgets/custom_text_field_widget.dart';

enum Gender { Male, Female, Other }

class SignupFormWidget extends StatefulWidget {
  final Function(
      String? role,
      String email,
      String password,
      String firstName,
      String lastName,
      String phone,
      String birthdate,
      String restaurantName) onContinuePressed;

  const SignupFormWidget({Key? key, required this.onContinuePressed})
      : super(key: key);

  @override
  _SignupFormWidgetState createState() => _SignupFormWidgetState();
}

class _SignupFormWidgetState extends State<SignupFormWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  final _restaurantNameController = TextEditingController(); // recently added

  Gender _selectedGender = Gender.Male;
  String? _selectedRole;

  String? _emailError;
  String? _firstNameError;
  String? _lastNameError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _birthdateError;
  String? _phoneError;
  String? _pinError;
  String? _restaurantNameError;
  bool _isPhoneConfirmed = false;
  bool _isSignupButtonActive = false;

  // TextEditingController getEmail(String email) {
  //   return _emailController;
  // }

  //   TextEditingController getpassword(String password) {
  //   return _passwordController;
  // }

  // Getter for email
  String get email => _emailController.text;

  // Getter for password
  String get password => _passwordController.text;

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_validateForm);
    _lastNameController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
    _birthdateController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _restaurantNameController.addListener(_validateForm);
  }

  void _validateFirstName() {
    setState(() {
      _firstNameError = _validateFirstNameText(_firstNameController.text);
    });
  }

  void _validateLastName() {
    setState(() {
      _lastNameError = _validateLastNameText(_lastNameController.text);
    });
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

  void _validateConfirmPassword() {
    setState(() {
      _confirmPasswordError = _validateConfirmPasswordText(
        _passwordController.text,
        _confirmPasswordController.text,
      );
    });
  }

  void _validateBirthdate() {
    setState(() {
      _birthdateError = _validateBirthdateText(_birthdateController.text);
    });
  }

  void _validatePhone() {
    setState(() {
      _phoneError = _validatePhoneText(_phoneController.text);
    });
  }

  void _validateRestaurantName() {
    setState(() {
      _restaurantNameError =
          _validateRestaurantNameText(_restaurantNameController.text);
    });
  }

  void _validateForm() {
    setState(() {
      _emailError = _validateEmailText(_emailController.text);
      _passwordError = _validatePasswordText(_passwordController.text);
      _confirmPasswordError = _validateConfirmPasswordText(
        _passwordController.text,
        _confirmPasswordController.text,
      );
      _birthdateError = _validateBirthdateText(_birthdateController.text);
      _phoneError = _validatePhoneText(_phoneController.text);
      _firstNameError = _validateFirstNameText(_firstNameController.text);
      _lastNameError = _validateLastNameText(_lastNameController.text);
      _restaurantNameError =
          _validateRestaurantNameText(_restaurantNameController.text);

      _isSignupButtonActive = _emailError == null &&
          _passwordError == null &&
          _firstNameError == null &&
          _lastNameError == null &&
          _confirmPasswordError == null &&
          _birthdateError == null &&
          _phoneError == null &&
          _firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _selectedRole != null &&
          _pinController.text == '0000' &&
          _isPhoneConfirmed == true &&
          (_selectedRole != 'Restaurant Manager' ||
              _restaurantNameController.text.isNotEmpty);
    });
  }

  String? _validateEmailText(String email) {
    if (email.isEmpty) {
      return "Email cannot be empty";
    }
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validateFirstNameText(String first) {
    if (first.isEmpty) {
      return "Name cannot be empty";
    }
    return null;
  }

  String? _validateLastNameText(String last) {
    if (last.isEmpty) {
      return "Name cannot be empty";
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

  String? _validateConfirmPasswordText(
      String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return "Confirm password cannot be empty";
    }
    if (password != confirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }

  String? _validateBirthdateText(String birthdate) {
    if (birthdate.isEmpty) {
      return "Birthdate cannot be empty";
    }
    final birthdateRegex =
        RegExp(r"^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/[0-9]{4}$");
    if (!birthdateRegex.hasMatch(birthdate)) {
      return "Enter a valid birthdate in MM/DD/YYYY format";
    }
    return null;
  }

  String? _validatePhoneText(String phone) {
    if (phone.isEmpty) {
      return "Phone number cannot be empty";
    }
    final phoneRegex = RegExp(r"^\d{11}$");
    if (!phoneRegex.hasMatch(phone)) {
      return "Enter a valid phone number";
    }
    return null;
  }

  String? _validateRestaurantNameText(String restaurantName) {
    if (_selectedRole == 'Restaurant Manager' && restaurantName.isEmpty) {
      return "Restaurant name cannot be empty";
    }
    return null;
  }

  void _handleSignup() {
    if (_isSignupButtonActive) {
      // Call the callback with the selected role, email, and password
      widget.onContinuePressed(
        _selectedRole,
        _emailController.text,
        _passwordController.text,
        _firstNameController.text,
        _lastNameController.text,
        _phoneController.text,
        _birthdateController.text,
        _selectedRole == 'Restaurant Manager'
            ? _restaurantNameController.text
            : '',
      );
    }
  }

  void _showPinInputModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter the PIN sent to your phone',
                    style: TextStyles.subtitleStyle
                        .copyWith(color: AppColors.signupColor),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFieldWidget(
                    controller: _pinController,
                    hintText: 'Enter PIN',
                    errorText: _pinError,
                    onChanged: (text) {
                      _validatePin();
                    },
                    keyboardType: TextInputType.number,
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButtonWidget(
                      text: 'Submit',
                      onButtonPressed: _validatePin,
                      backgroundColor: AppColors.buttonLoginBackgroundColor,
                      textColor: AppColors.buttonLoginTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _validatePin() {
    setState(() {
      _pinError = _validatePinText(_pinController.text);
    });

    if (_pinError == null) {
      setState(() {
        _isPhoneConfirmed = true;
      });
      Navigator.pop(context); // Close the bottom sheet
    }
  }

  String? _validatePinText(String pin) {
    if (pin.isEmpty) {
      return "PIN cannot be empty";
    }
    if (pin != '0000') {
      return "Invalid PIN";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _CustomLabelText("First Name"),
                  const SizedBox(height: 8),
                  CustomTextFieldWidget(
                    controller: _firstNameController,
                    hintText: "First name",
                    errorText: _firstNameError,
                    onChanged: (text) {
                      _validateFirstName();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _CustomLabelText("Last Name"),
                  const SizedBox(height: 8),
                  CustomTextFieldWidget(
                    controller: _lastNameController,
                    hintText: "Last name",
                    errorText: _lastNameError,
                    onChanged: (text) {
                      _validateLastName();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const _CustomLabelText("E-mail"),
        const SizedBox(height: 8),
        CustomTextFieldWidget(
          controller: _emailController,
          hintText: "Enter your email",
          errorText: _emailError,
          onChanged: (text) {
            _validateEmail();
          },
          keyboardType: TextInputType.emailAddress,
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
        const _CustomLabelText("Confirm Password"),
        const SizedBox(height: 8),
        PasswordFieldWidget(
          controller: _confirmPasswordController,
          errorText: _confirmPasswordError,
          onChanged: (text) {
            _validateConfirmPassword();
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _CustomLabelText("Birthdate"),
                  const SizedBox(height: 8),
                  CustomTextFieldWidget(
                    controller: _birthdateController,
                    errorText: _birthdateError,
                    hintText: "MM/DD/YYYY",
                    onChanged: (text) {
                      _validateBirthdate();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _CustomLabelText("Gender"),
                  const SizedBox(height: 8),
                  DropdownButton<Gender>(
                    isExpanded: true,
                    value: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: Gender.Male,
                        child: Text("Male",
                            style: _selectedGender == Gender.Male
                                ? TextStyles.fieldStyle.copyWith(
                                    color: AppColors.selectedItemColor)
                                : TextStyles.fieldStyle.copyWith(
                                    color: AppColors.unselectedItemColor)),
                      ),
                      DropdownMenuItem(
                        value: Gender.Female,
                        child: Text("Female",
                            style: _selectedGender == Gender.Female
                                ? TextStyles.fieldStyle.copyWith(
                                    color: AppColors.selectedItemColor)
                                : TextStyles.fieldStyle.copyWith(
                                    color: AppColors.unselectedItemColor)),
                      ),
                      DropdownMenuItem(
                        value: Gender.Other,
                        child: Text("Other",
                            style: _selectedGender == Gender.Other
                                ? TextStyles.fieldStyle.copyWith(
                                    color: AppColors.selectedItemColor)
                                : TextStyles.fieldStyle.copyWith(
                                    color: AppColors.unselectedItemColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _CustomLabelText("Phone Number"),
                  const SizedBox(height: 8),
                  CustomTextFieldWidget(
                    controller: _phoneController,
                    hintText: "Enter your phone number",
                    errorText: _phoneError,
                    onChanged: (text) {
                      _validatePhone();
                    },
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {
                          _showPinInputModal();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          backgroundColor:
                              AppColors.confirmButtonBackgroundColor,
                        ),
                        child: Text(
                          "Confirm",
                          style: TextStyles.subtitleStyle.copyWith(
                              color: AppColors.confirmButtonTextColor),
                        ),
                      ),
                    ),
                    if (_phoneError != null) const SizedBox(height: 26.0),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: DropdownButton<String>(
            value: _selectedRole,
            hint: Text(
              'Choose a role',
              style: TextStyles.fieldStyle
                  .copyWith(color: AppColors.hintTextColor),
            ),
            onChanged: (String? newValue) {
              setState(() {
                _selectedRole = newValue;
              });
              _validateForm(); // Validate form whenever role is changed
            },
            icon: const Icon(Icons.arrow_drop_down),
            isExpanded: true,
            items: <String>['Restaurant Manager', 'Driver', 'Factory Manager']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: _selectedRole == value
                        ? TextStyles.fieldStyle
                            .copyWith(color: AppColors.selectedItemColor)
                        : TextStyles.fieldStyle
                            .copyWith(color: AppColors.unselectedItemColor)),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        if (_selectedRole ==
            'Restaurant Manager') // Show only if role is Restaurant Manager
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _CustomLabelText("Restaurant Name"),
                const SizedBox(height: 8),
                CustomTextFieldWidget(
                  controller: _restaurantNameController,
                  hintText: "Enter restaurant name",
                  errorText: _restaurantNameError,
                  onChanged: (text) {
                    _validateRestaurantName();
                  },
                ),
              ],
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: CustomButtonWidget(
            onButtonPressed: () {
              _validateForm();
              if (_isSignupButtonActive) {
                _handleSignup();
              }
            },
            text: "Continue",
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
      style: TextStyles.subtitleStyle.copyWith(color: AppColors.subtitleColor),
    );
  }
}
