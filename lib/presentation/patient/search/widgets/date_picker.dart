import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  const DateSelector(
      {super.key, this.selectedDate, required this.onDateSelected});

  final String? selectedDate;
  final void Function(String?) onDateSelected;

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? _pickedDate;

  @override
  void initState() {
    super.initState();
    _pickedDate = widget.selectedDate != null
        ? DateTime.parse(widget.selectedDate!)
        : null;
  }

  // @override
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _pickedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _pickedDate = picked;
      });
      widget.onDateSelected(_pickedDate!.toString());
    }
  }

  void _clearDate() {
    setState(() {
      _pickedDate = null;
    });
    widget.onDateSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 10,
          ),
          const Icon(Icons.calendar_today),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Text(
              _pickedDate != null
                  ? _pickedDate.toString().split(' ')[0]
                  : 'Select a date',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const Spacer(),
          if (_pickedDate != null)
            IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black.withOpacity(0.5),
              ),
              onPressed: () => _clearDate(),
            ),
        ],
      ),
    );
  }
}
