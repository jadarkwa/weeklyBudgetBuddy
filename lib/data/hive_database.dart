import 'package:hive/hive.dart';
import 'package:weeklyfinancetracker/models/expense_item.dart';

class HiveDataBase {
  final _myBox = Hive.box("expense_database2");

  void saveData(List<ExpenseItem> allExpense, double weeklyBudget) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];

      allExpensesFormatted.add(expenseFormatted);
    }

    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
    _myBox.put("WEEKLY_BUDGET", weeklyBudget);
  }

  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      // collect individual expense data
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // create expense item
      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      // add expense to overall list of expenses
      allExpenses.add(expense);
    }

    return allExpenses;
  }

  double readWeeklyBudget() {
    return _myBox.get("WEEKLY_BUDGET", defaultValue: 0.0);
  }
}
