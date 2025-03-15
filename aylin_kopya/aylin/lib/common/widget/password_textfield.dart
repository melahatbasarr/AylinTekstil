import 'package:aylin/common/widget/custom_widgets.dart';
import 'package:aylin/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final FormFieldValidator<String>? validator;

  const PasswordTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _visibility = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomWidgets.blackText(widget.title),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          obscureText: !_visibility,
          decoration: InputDecoration(
            isDense: true,
            fillColor: CustomColors.textField,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _visibility = !_visibility;
                });
              },
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Icon(
                _visibility
                    ? Icons.remove_red_eye_outlined
                    : Icons.visibility_off_rounded,
                color: Colors.black,
              ),
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
