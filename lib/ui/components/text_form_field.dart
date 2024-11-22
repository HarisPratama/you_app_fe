import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final bool isPassword; // To indicate whether the input is for a password or not
  final TextInputType keyboardType;

  // Constructor for initializing fields
  const InputField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: TextFormField(
        obscureText: widget.isPassword && !_isPasswordVisible, // Toggle password visibility
        keyboardType: widget.keyboardType, // Email or Text field
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.hintText, // Display the passed hint text
          hintStyle: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.4),
          ),
          fillColor: const Color.fromRGBO(255, 255, 255, 0.06),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible; // Toggle password visibility
                    });
                  },
                )
              : null, // No icon for non-password fields
        ),
      ),
    );
  }
}
