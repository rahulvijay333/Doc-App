import 'package:flutter/material.dart';

class SpecialtySelectionDialog extends StatelessWidget {
  final List<String> specialties;
  final Function(String) onSpecialtySelected;

  SpecialtySelectionDialog({
    required this.specialties,
    required this.onSpecialtySelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose Speciality'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: specialties
            .map(
              (specialty) => ListTile(
                title: Text(specialty),
                onTap: () {
                  onSpecialtySelected(specialty);
                  Navigator.of(context).pop();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
