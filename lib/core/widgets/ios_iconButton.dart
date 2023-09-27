import 'package:flutter/cupertino.dart';

class IOSIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;

  const IOSIconButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero, // Padding'i sıfıra ayarlayarak simgenin etrafındaki boşluğu kaldırır.
      child: Icon(
        icon,
        size: 24, // Sizin için uygun olan simge boyutunu ayarlayın.
        color: CupertinoColors.activeBlue, // Sizin için uygun olan renki ayarlayın.
      ),
    );
  }
}
