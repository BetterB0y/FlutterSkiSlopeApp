// ignore_for_file: avoid_shadowing_type_parameters

import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get text => AppLocalizations.of(this)!;
}

extension IterableExt<T, R> on Iterable<T> {
  List<R> mapToList<R>(R Function(T element) map, {bool growable = true}) =>
      this.map<R>(map).toList(growable: growable);
}

void printError(Object? object) {
  debugPrint('\x1B[31m$object\x1B[0m', wrapWidth: 1024);
}
