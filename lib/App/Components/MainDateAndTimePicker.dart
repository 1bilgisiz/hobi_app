import 'package:flutter/material.dart';
import 'package:hobiapp/Utils/Palette.dart';

class MainDateAndTimePicker extends StatefulWidget {
  final Widget validateWidget;
  final String text;
  final Function setFunction;
  final DateTime? selectTime;
  final int firstDate;
  final int lastDate;
  final bool isHourRequired;
  const MainDateAndTimePicker(
      {required this.validateWidget,
      required this.text,
      this.isHourRequired = true,
      required this.setFunction,
      required this.selectTime,
      this.firstDate = 2000,
      this.lastDate = 2100,
      super.key});

  @override
  State<MainDateAndTimePicker> createState() => _MainDateAndTimePickerState();
}

class _MainDateAndTimePickerState extends State<MainDateAndTimePicker> {
  DateTime dateTimeNow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        pickDateTime();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.selectTime != null
              ? Container(
                  margin: const EdgeInsets.only(left: 35),
                  child: Text(
                    widget.text,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                )
              : const SizedBox.shrink(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 60,
            width: width,
            decoration: BoxDecoration(
              color: Palette.lightGrey2.withOpacity(.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.date_range),
                const SizedBox(width: 10),
                Text(
                  widget.selectTime == null
                      ? widget.text
                      : widget.isHourRequired
                          ? "${widget.selectTime!.day.toString().padLeft(2, '0')}/${widget.selectTime!.month.toString().padLeft(2, '0')}/${widget.selectTime!.year} ${widget.selectTime!.hour.toString().padLeft(2, '0')}:${widget.selectTime!.minute.toString().padLeft(2, '0')}:${widget.selectTime!.second.toString().padLeft(2, '0')}"
                          : "${widget.selectTime!.day.toString().padLeft(2, '0')}/${widget.selectTime!.month.toString().padLeft(2, '0')}/${widget.selectTime!.year}",
                  style: TextStyle(
                    color: Palette.black.withOpacity(.6),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          widget.validateWidget,
        ],
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = widget.isHourRequired
        ? await pickTime()
        : TimeOfDay(hour: dateTimeNow.hour, minute: dateTimeNow.minute);
    if (time == null) return;
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      widget.setFunction(dateTime);
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
        locale: const Locale("tr", "TR"),
        context: context,
        initialDate:
            widget.selectTime != null ? widget.selectTime! : dateTimeNow,
        firstDate: DateTime(widget.firstDate),
        lastDate: DateTime(widget.lastDate),
      );

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: widget.selectTime != null
                ? widget.selectTime!.hour
                : dateTimeNow.hour,
            minute: widget.selectTime != null
                ? widget.selectTime!.minute
                : dateTimeNow.minute),
      );
}
