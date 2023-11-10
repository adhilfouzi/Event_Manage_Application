import 'package:flutter/material.dart';
import 'package:project_event/Core/Color/color.dart';
import 'package:project_event/Core/Color/font.dart';

class TextFieldBlue extends StatelessWidget {
  final String textcontent;
  final String? Function(String?)? validator;
  final IconData? preicondata;
  final IconData? posticondata;
  final TextEditingController? controller;
  final TextInputType? keyType;
  final bool? obscureText;
  final bool? enabled;

  const TextFieldBlue({
    super.key,
    required this.textcontent,
    this.preicondata,
    this.posticondata,
    this.controller,
    this.validator,
    this.keyType,
    this.obscureText,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15),
          child: Text(textcontent, style: raleway()),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: TextFormField(
            enabled: enabled == null ? true : false,
            obscureText: obscureText == null ? false : true,
            keyboardType: keyType,
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 3,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(
                  color: buttoncolor,
                  width: 1.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
                borderSide: const BorderSide(
                  color: buttoncolor,
                  width: 1,
                ),
              ),
              iconColor: buttoncolor,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              prefixIcon: preicondata != null
                  ? Icon(preicondata, size: 24, color: buttoncolor[700])
                  : null,
              suffixIcon: posticondata != null
                  ? Icon(posticondata, size: 24, color: buttoncolor[700])
                  : null,
              hintText: textcontent,
              hintStyle: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                fontFamily: 'Raleway',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
