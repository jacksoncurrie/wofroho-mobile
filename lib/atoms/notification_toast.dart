import 'package:flutter/material.dart';

class NotificationToast extends StatelessWidget {
  NotificationToast({
    required this.isShown,
    required this.child,
    this.color = Colors.white,
  });

  final bool? isShown;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: AnimatedOpacity(
          curve: Curves.ease,
          duration: Duration(milliseconds: 400),
          opacity: isShown! ? 1.0 : 0.0,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 14,
                  offset: Offset(0, 10),
                ),
              ],
              borderRadius: BorderRadius.circular(1),
            ),
            padding: const EdgeInsets.all(15),
            child: child,
          ),
        ),
      ),
    );
  }
}
