import 'package:flutter/material.dart';

class ConditionalBuilder extends StatelessWidget {
  final bool condition;
  final WidgetBuilder positiveBuilder;
  final WidgetBuilder? negativeBuilder;

  const ConditionalBuilder({
    Key? key,
    required this.condition,
    required this.positiveBuilder,
    this.negativeBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return condition ? positiveBuilder(context) : (negativeBuilder?.call(context) ?? const SizedBox());
  }
}
