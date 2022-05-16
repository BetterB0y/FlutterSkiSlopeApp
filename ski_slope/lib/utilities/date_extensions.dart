import 'package:intl/intl.dart';

final _yyyyMMddHHmmFormatter = DateFormat('dd.MM.yyyy HH:mm');

extension DateHelpers on DateTime {
  String get asFullDateText => _yyyyMMddHHmmFormatter.format(this);
}
