  import 'package:flutter/material.dart';

Widget loginField(
      String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
      ),
    );
  }
