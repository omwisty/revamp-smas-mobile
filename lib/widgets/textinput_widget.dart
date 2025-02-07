import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextInputStyleType {
  standard,
  border,
}

class TextInputWidget extends StatelessWidget {
  TextInputWidget({
    Key? key,
    required this.label,
    required this.name,
    this.isPassword = false,
    this.type = TextInputStyleType.standard,
    this.onPressed,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.initialValue = "",
    this.readOnly = false
  }) : super(key: key);

  final String label;
  final String name;
  final bool isPassword;
  TextInputStyleType type;
  final Function()? onPressed;
  final Widget? suffixIcon;
  String initialValue;
  FormFieldValidator<String>? validator;
  ValueChanged<String?>? onChanged;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        type == TextInputStyleType.standard
          ? Text(label, style: TextStyle(fontSize: ScreenUtil().setSp(14)))
          : Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 10),
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
        FormBuilderTextField(
          name: name,
          obscureText: isPassword,
          keyboardType: TextInputType.text,
          decoration: type == TextInputStyleType.standard
            ? InputDecoration(
                hintText: name,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 12.0),
                suffixIcon: suffixIcon,
              )
            : InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                hintText: name,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 12.0),
                suffixIcon: suffixIcon,
              ),
          validator: validator,
          onChanged: onChanged,
          initialValue: initialValue,
          readOnly: readOnly
        ),
      ],
    );
  }

}