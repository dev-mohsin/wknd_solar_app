import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format({String format = "yMd"}) {
    return DateFormat.yMd().format(this);
  }

  String time({String format = "jm"}) {
    return DateFormat.jm().format(this);
  }

}
