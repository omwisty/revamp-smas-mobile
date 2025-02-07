import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatelessWidget {
  DatePickerWidget({
    Key? key,
    required this.label,
    required this.name,
    this.firstDate,
    this.endDate,
    this.validator,
    this.onChanged,
    this.initialDate,
  }) : super(key: key);

  final String label;
  final String name;
  final DateTime? firstDate;
  final DateTime? endDate;
  final ValueChanged<DateTime?>? onChanged;
  final DateTime? initialDate;
  FormFieldValidator<DateTime>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 10),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: FormBuilderDateTimePicker(
            onChanged: onChanged,
            name: name,
            inputType: InputType.date,
            format: DateFormat("yyyy-MM-dd"),
            initialValue: DateFormat("yyyy-MM-dd").parse(DateTime.now().toString()),
            firstDate: firstDate,
            lastDate: endDate,
            decoration: InputDecoration(
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
              suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey, size: 20.0),
            ),
            validator: validator,
          )
        ),
      ],
    );
  }

}