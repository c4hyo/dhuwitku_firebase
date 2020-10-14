import 'package:intl/intl.dart';

String rupiah({int nominal}) {
  return NumberFormat.currency(locale: "id", symbol: "Rp. ", decimalDigits: 0)
      .format(nominal);
}
