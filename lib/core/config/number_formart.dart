import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  final NumberFormat formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
  return formatter.format(amount);
}