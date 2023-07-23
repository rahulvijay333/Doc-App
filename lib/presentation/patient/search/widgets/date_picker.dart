// import 'package:flutter/material.dart';

// class DateSelector extends StatefulWidget {
//   final String selectedDate;
//   final void Function(String) onDateSelected;

//   DateSelector({required this.selectedDate, required this.onDateSelected});

//   @override
//   _DateSelectorState createState() => _DateSelectorState();
// }

// class _DateSelectorState extends State<DateSelector> {
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2101),
//     );

//     if (picked != null && picked != DateTime.parse(widget.selectedDate)) {
//       widget.onDateSelected(picked.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: InkWell(
//         onTap: () => _selectDate(context),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Icon(Icons.calendar_today),
//             Text(
//               widget.selectedDate,
//               style: TextStyle(color: Colors.black, fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  final String? selectedDate;
  final void Function(String?) onDateSelected;

  DateSelector({this.selectedDate, required this.onDateSelected});

  @override
  _DateSelectorState createState() => _DateSelectorState();
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
          SizedBox(
            width: 10,
          ),
          Icon(Icons.calendar_today),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: Text(
              _pickedDate != null
                  ? _pickedDate.toString().split(' ')[0]
                  : 'Select a date',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Spacer(),
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
