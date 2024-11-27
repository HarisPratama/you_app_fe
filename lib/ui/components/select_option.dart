import 'package:flutter/material.dart';
import 'package:you_app/shared/theme.dart';

class SelectOption extends StatefulWidget {
  const SelectOption({
    Key? key,
    required this.onValueChanged,
  }) : super(key: key);

  
  final ValueChanged<String?> onValueChanged;

  @override
  _SelectOptionState createState() => _SelectOptionState();
}

class _SelectOptionState extends State<SelectOption> {
  // List of options
  final List<String> _options = ['Male', 'Female'];

  // Selected value
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(255, 255, 255, 0.22),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DropdownButton<String>(
        isExpanded: true,
        value: _selectedOption,
        hint: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Select gender',
            style: grayTextStyle.copyWith(
              fontSize: 13,
              fontWeight: medium,
            ),
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            _selectedOption = newValue;
          });

          widget.onValueChanged(newValue);
        },
        items: _options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  style: whiteTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        dropdownColor: kSecondaryBlackColor,
        style: grayTextStyle.copyWith(
          fontSize: 14,
          fontWeight: medium,
        ),
        underline: const SizedBox.shrink(),
      ),
    );
  }
}
