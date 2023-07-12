import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:info_widget/info_widget.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.infoText,
    this.hintText,
  });

  final String labelText;
  final TextEditingController controller;
  final String infoText;
  final String? hintText;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 300,
      child: TextFormField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(
              RegExp('^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)'))
        ],
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          suffixIcon: InfoWidget(
            infoText: widget.infoText,
            iconData: Icons.question_mark_rounded,
            iconColor: Colors.black,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Введены некорректные координаты';
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            widget.controller.text = value;
          });
        },
      ),
    );
  }
}
