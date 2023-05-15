import 'package:intl/intl.dart';

String currencyFormatter(double value) {
  return NumberFormat.simpleCurrency(locale: "en_IN").format(value);
}
