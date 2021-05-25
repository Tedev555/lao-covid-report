import 'package:intl/intl.dart';

class Utils {
  static String formatNumber(int number) {
    return NumberFormat('#,###').format(number);
  }
}
