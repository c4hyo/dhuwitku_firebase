import 'package:intl/intl.dart';

String rupiah({int nominal}) {
  return NumberFormat.currency(locale: "id", symbol: "Rp. ", decimalDigits: 0)
      .format(nominal);
}

String tglIndo({String tanggal}) {
  return DateFormat("EEEE, d MMMM yyyy", "id_ID").format(
    DateTime.parse(tanggal),
  );
}
