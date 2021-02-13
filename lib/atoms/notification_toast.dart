import 'package:flutter/material.dart';

class NotificationToast extends StatelessWidget {
  NotificationToast({
    @required this.isShown,
    @required this.child,
    this.color = Colors.white,
  });

  final bool isShown;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: AnimatedOpacity(
            curve: Curves.ease,
            duration: Duration(milliseconds: 400),
            opacity: isShown ? 1.0 : 0.0,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 7,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
