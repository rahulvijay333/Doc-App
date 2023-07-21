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
    hintText: 'Password',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.blue, // Set the focused border color
      ),
    ),
    filled: true,
    fillColor: Colors.white,
    enabled: true,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent)));

final textfieldInputDecorationEmail = InputDecoration(
    hintText: 'Email',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.blue, // Set the focused border color
      ),
    ),
    filled: true,
    fillColor: Colors.white,
    enabled: true,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.transparent)));

final loginButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<OutlinedBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  minimumSize: MaterialStateProperty.all<Size>(
    const Size(double.maxFinite, 50),
  ),
);
