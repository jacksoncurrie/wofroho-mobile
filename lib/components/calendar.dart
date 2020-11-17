import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme.dart';

class Calendar extends StatelessWidget {
  Calendar({
    @required this.selectedDayIndex,
    @required this.newDaySelected,
  });

  final int selectedDayIndex;
  final Function(int newDayIndex) newDaySelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _showArrowLeft(),
            Text("October, 2020"),
            _showArrowRight(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _createDay(context, "Mo", 8, 0),
              _createDay(context, "Tu", 9, 1),
              _createDay(context, "We", 10, 2),
              _createDay(context, "Th", 11, 3),
              _createDay(context, "Fr", 12, 4),
              _createDay(context, "Sa", 13, 5),
              _createDay(context, "Su", 14, 6),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showArrowLeft() {
    return SvgPicture.asset(
      'assets/arrow_left.svg',
      semanticsLabel: "Arrow left",
    );
  }

  Widget _showArrowRight() {
    return SvgPicture.asset(
      'assets/arrow_right.svg',
      semanticsLabel: "Arrow right",
    );
  }

  Widget _createDay(BuildContext context, String name, int date, int dayIndex) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            name,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        GestureDetector(
          onTap: () => newDaySelected(dayIndex),
          child: Container(
            width: 40.0,
            height: 40.0,
            color: dayIndex == selectedDayIndex
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            child: Center(
              child: Text(
                date.toString(),
                style: TextStyle(
                  fontSize: 20.0,
                  color: dayIndex == selectedDayIndex
                      ? Theme.of(context).colorScheme.textOnPrimary
                      : Theme.of(context).colorScheme.disabledText,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
