import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}

//convert 24 hour 18:00:00 to 12 hour 6:00 PM
String convertTime(String time) {
  final format = DateFormat.jm();
  final date = DateTime.parse('2020-01-01 $time');
  return format.format(date);
}

String getStatus(int status) {
  switch (status) {
    case 0:
      return 'Pending';
    case 1:
      return 'Accepted';
    case 2:
      return 'Rejected';
    case 3:
      return 'Cancelled';
    case 4:
      return 'Completed';
    default:
      return 'Pending';
  }
}
