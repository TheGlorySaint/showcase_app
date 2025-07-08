import 'package:intl/intl.dart';

class DateHelper {
  final DateTime _now = DateTime.now();

  late final String time = DateFormat.Hm().format(_now);
  late final String date = DateFormat('dd.MM.yyyy').format(_now);
  late final String weekday = DateFormat('EEEE', 'en_US').format(_now);
}
