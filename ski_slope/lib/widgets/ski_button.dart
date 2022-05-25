import 'package:flutter/material.dart';
import 'package:ski_slope/resources/colors.dart';

class SkiButton extends StatelessWidget {
  const SkiButton({Key? key, required this.onPressed, required this.child, this.style}) : super(key: key);
  final VoidCallback? onPressed;
  final Widget? child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ??
          ElevatedButton.styleFrom(
            primary: SkiColors.buttonsColor,
            onPrimary: SkiColors.additionalColor,
          ),
      onPressed: onPressed,
      child: child,
    );
  }
}
