import 'package:fitnesapp/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  final Function(DateTime) onDateChanged; // Callback to notify date changes

  const DateSelector({super.key, required this.onDateChanged});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDate = DateTime.now();
  int weekOffset = 0;

  List<DateTime> generateWeekDates(int weekOffset) {
    final today = DateTime.now();
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    startOfWeek = startOfWeek.add(Duration(days: weekOffset * 7));
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> weekDates = generateWeekDates(weekOffset);
    String monthName = DateFormat('MMMM').format(weekDates.first);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(
            bottom: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  setState(() {
                    weekOffset--;
                  });
                },
              ),
              Text(
                monthName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  setState(() {
                    weekOffset++;
                  });
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weekDates.length,
              itemBuilder: (context, index) {
                DateTime date = weekDates[index];
                bool isSelected = DateFormat('d').format(selectedDate) ==
                        DateFormat('d').format(date) &&
                    selectedDate.month == date.month &&
                    selectedDate.year == date.year;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                    widget.onDateChanged(selectedDate); // Notify parent widget
                  },
                  child: Container(
                    width: 70,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppConstants.yellow
                          : AppConstants.purple,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? AppConstants.yellow
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('d').format(date),
                          style: TextStyle(
                            color: isSelected
                                ? const Color.fromARGB(221, 0, 0, 0)
                                : const Color.fromARGB(221, 0, 0, 0),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          DateFormat('E').format(date),
                          style: TextStyle(
                            color: isSelected
                                ? const Color.fromARGB(221, 109, 106, 106)
                                : const Color.fromARGB(221, 109, 106, 106),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
