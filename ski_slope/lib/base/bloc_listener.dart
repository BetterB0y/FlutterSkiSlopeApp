import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ski_slope/base/stated_bloc.dart';

class BlocListener<T extends StatedBloc> extends StatefulWidget {
  final Function(dynamic state) onChanged;
  final Function(BuildContext context) builder;
  final T? bloc;

  const BlocListener({
    Key? key,
    required this.onChanged,
    required this.builder,
    this.bloc,
  }) : super(key: key);

  @override
  State createState() => _BlocListenerState<T>();
}

class _BlocListenerState<T extends StatedBloc> extends State<BlocListener<T>> {
  late T _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc ?? BlocProvider.getBloc<T>();
    _bloc.addListener(_onChanged);
  }

  @override
  void dispose() {
    _bloc.removeListener(_onChanged);
    super.dispose();
  }

  _onChanged() {
    widget.onChanged(_bloc.state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
