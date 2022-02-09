import 'package:intl/intl.dart';
import 'package:miraki_app/constants/constants.dart';

getIndianCurrency(double money) => NumberFormat.currency(
    locale: 'en_IN', customPattern: '$rupeeSymbol##,###.#')
    .format(money);