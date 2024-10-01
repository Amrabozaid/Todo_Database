import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  String timeString;
  TimePicker({
    super.key,
    this.timeString="9:00 AM"
  });

  @override
  TimePickerState createState() => TimePickerState();
}

class TimePickerState extends State<TimePicker> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9,minute: 0);
  TimePicker timePicker=TimePicker();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        widget.timeString = _selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        color: const Color.fromARGB(255, 198, 198, 198),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.access_time, color: Colors.black),
            Text(_selectedTime.format(context))
            
          ],
        ),
      )
    );
  }
}




