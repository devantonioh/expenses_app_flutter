import 'package:intl/intl.dart';

import '../models/expenses_model.dart';
import '../models/models.dart';
export 'package:expenses_app/utils/math_operations.dart';

getAmountFormat(double amount) {
  return NumberFormat.simpleCurrency().format(amount);
}

/* obtener la suma de expenses */
getSumOfExP(List<ExpensesModel> eList) {
  double _eList;
  _eList = eList.map((e) => e.expense).fold(0.0, (a, b) => a + b);
  return _eList;
}

/* obtener la suma de entries*/
getSumOfEntries(List<EntriesModel> eList) {
  double _etList;
  _etList = eList.map((e) => e.entries).fold(0.0, (a, b) => a + b);
  return _etList;
}

/* obtener el balance */
getBalance(List<ExpensesModel> eList, List<EntriesModel> etList) {
  double _balance;
  _balance = getSumOfEntries(etList) - getSumOfExP(eList);
  return getAmountFormat(_balance);
}
