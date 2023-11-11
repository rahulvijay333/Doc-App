import 'package:flutter/material.dart';

final backgroundDecoration = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
      const Color.fromRGBO(0, 150, 255, 20),
      Colors.white.withOpacity(0.2)
    ]));

final textfieldInputDecorationPassword = InputDecoration(
  suffixIcon: IconButton(onPressed: () {
    
  }, icon: Icon(Icons.visibility,size: 15,)),
    hintText: 'Enter Your Password',
    counterText: "",
     hintStyle: const TextStyle(
      color: Colors.grey
    ),
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
    hintStyle: const TextStyle(
      color: Colors.grey
    ),
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
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    labelStyle: const TextStyle(
      color: Colors.black, // Set the label text color
    ),
  );
}

InputDecoration customOtpBoxdecoration() {
  return const InputDecoration(
    focusColor: Colors.red,
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(),
    counterText: '',
  );
}

var appBackGround = const Color.fromRGBO(0, 116, 217, 1);
