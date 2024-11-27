import 'package:flutter/material.dart';

import 'package:you_app/shared/theme.dart';


class DateInput extends StatefulWidget {
  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  DateTime? _selectedDate; // Stores the selected date
  final TextEditingController _dateController = TextEditingController(); // Controller for the input field

  Future<void> _selectDate(BuildContext context) async {
    print('halo');
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), // Earliest date
      lastDate: DateTime(2100), // Latest date
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text =
            "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"; // Format date
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      readOnly: true, // Prevents keyboard from appearing
      decoration: InputDecoration(
        hintText: "DD MM YYYY",
        hintStyle: grayTextStyle.copyWith(
          fontSize: 13,
          fontWeight: medium
        ),
        fillColor: Color.fromRGBO(217, 217, 217, 0.06),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.22)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        alignLabelWithHint: true
      ),
      textAlign: TextAlign.right,
      style: whiteTextStyle.copyWith(
        fontSize: 13,
        fontWeight: medium,
      ),
      onTap: () => _selectDate(context), // Open date picker on tap
    );
  }
}

void main() {
  runApp(MaterialApp(home: DateInput()));
}
