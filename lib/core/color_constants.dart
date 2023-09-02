import 'package:flutter/material.dart';

final backgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
      Color.fromRGBO(0, 150, 255, 20),
      Colors.white.withOpacity(0.2)
    ]));

final textfieldInputDecorationPassword = InputDecoration(
    hintText: 'Enter Your Password',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.blue, // Set the focused border color
      ),
    ),
    filled: true,
    fillColor: Colors.grey.withOpacity(0.1),
    enabled: true,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent)));

final textfieldInputDecorationEmail = InputDecoration(
    hintText: 'Enter Your Email',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.blue, // Set the focused border color
      ),
    ),
    filled: true,
    fillColor: Colors.grey.withOpacity(0.1),
    enabled: true,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent)));

final loginButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(appBackGround),
  shape: MaterialStateProperty.all<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  minimumSize: MaterialStateProperty.all<Size>(
    const Size(double.maxFinite, 50),
  ),
);

final AppointmentButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    minimumSize: MaterialStateProperty.all<Size>(
      const Size(10, 20),
    ),
    maximumSize: MaterialStateProperty.all<Size>(
      const Size(10, 20),
    ));

InputDecoration commonInputDecoration({
  String? label,
  String? hint,
  Color focusedBorderColor = Colors.blue,
}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: focusedBorderColor, // Set the focused border color
      ),
    ),
    filled: true,
    fillColor: Colors.white,
    enabled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    labelStyle: TextStyle(
      color: Colors.black, // Set the label text color
    ),
  );
}


  InputDecoration customOtpBoxdecoration() {
    return InputDecoration(
      focusColor: Colors.red,
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(),
      counterText: '',
    );
  }


var appBackGround =  Color.fromRGBO(0, 116, 217, 1);