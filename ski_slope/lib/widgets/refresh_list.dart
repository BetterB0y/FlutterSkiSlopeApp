import 'package:flutter/material.dart';
import 'package:ski_slope/resources/colors.dart';

class RefreshList extends StatelessWidget {
  final Widget child;
  final bool? isRefreshing;
  final VoidCallback onRefresh;

  const RefreshList({
    Key? key,
    required this.child,
    required this.isRefreshing,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: SkiColors.backgroundColor,
      backgroundColor: SkiColors.mainColor,
      onRefresh: () async => onRefresh(),
      child: child,
    );
  }
}
