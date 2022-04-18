import 'package:flutter/material.dart';
import 'package:ski_slope/base/stated_bloc.dart';

class BlocBuilder<T> extends StatefulWidget {
  final StatedBloc bloc;
  final WidgetBuilderBloc builder;

  const BlocBuilder({
    Key? key,
    required this.bloc,
    required this.builder,
  }) : super(key: key);

  @override
  State createState() {
    return BlocBuilderState();
  }
}

class BlocBuilderState extends State<BlocBuilder> {
  @override
  void initState() {
    super.initState();
    widget.bloc.addListener(_listener);
  }

  @override
  void dispose() {
    widget.bloc.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.bloc);
  }
}

typedef WidgetBuilderBloc = Widget Function(BuildContext context, StatedBloc bloc);
