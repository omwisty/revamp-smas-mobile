import 'package:intl/intl.dart';

String dateString() {
  var now = DateTime.now();
  return DateFormat("EE, d MMM y").format(now);
}

String timeString() {
  var now = DateTime.now();
  return DateFormat("HH:mm:ss").format(now);
}

String dateHumanFormat(DateTime date) {
  return DateFormat("dd MMM yyyy").format(date);
}

String timeFormat(DateTime date) {
  return DateFormat("HH:mm").format(date);
}