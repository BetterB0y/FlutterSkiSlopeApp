import 'package:flutter/material.dart';

Future<T?> navigateToPage<T>(
  BuildContext context, {
  required WidgetBuilder builder,
}) {
  return Navigator.of(context)
      .push<T>(
        MaterialPageRoute<T>(
          builder: builder,
        ),
      )
      .then((value) => value);
}

void navigateBack<T>(BuildContext context, [T? result]) {
  Navigator.of(context).pop<T>(result);
}
