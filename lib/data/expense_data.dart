import 'package:flutter/material.dart';
import 'package:weeklyfinancetracker/data/hive_database.dart';
import 'package:weeklyfinancetracker/datetime/date_time_helper.dart';
import 'package:weeklyfinancetracker/models/expense_item.dart';

class ExpenseData extends ChangeNotifier{
List<ExpenseItem> overallExpenseList = [];
double _weeklyBudget = 0.0;



List<ExpenseItem> getAllExpenseList(){
  return overallExpenseList;
}

final db = HiveDataBase();

  void prepareData() {
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
    _weeklyBudget = db.readWeeklyBudget();
  }


  void setWeeklyBudget(double budget) {
    _weeklyBudget = budget;
    notifyListeners();
    db.saveData(overallExpenseList, _weeklyBudget); // Save budget to database if needed
  }

  double get weeklyBudget => _weeklyBudget;

void addNewExpense(ExpenseItem newExpense){
  _weeklyBudget -= double.parse(newExpense.amount);
  overallExpenseList.add(newExpense);
  notifyListeners();
  db.saveData(overallExpenseList, _weeklyBudget);
}

void deleteExpense(ExpenseItem expense){
  _weeklyBudget += double.parse(expense.amount);
  overallExpenseList.remove(expense);
  notifyListeners();
  db.saveData(overallExpenseList, _weeklyBudget); 
}





String getDayName(DateTime dateTime) {
  switch (dateTime.weekday) {
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thur';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
    default:
      return '';
  }
}


// Get the date for the start of the week (Sunday)
DateTime startOfWeekDate() {
  DateTime? startOfWeek;

  // Get today's date
  DateTime today = DateTime.now();

  // Go backwards from today to find Sunday
  for (int i = 0; i < 7; i++) {
    if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
      startOfWeek = today.subtract(Duration(days: i));
    }
  }

  return startOfWeek!;
}

Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
        // date (yyyymmdd) : amountTotalForDay
    };

    for (var expense in overallExpenseList) {
        String date = convertDateTimeToString(expense.dateTime);
        double amount = double.parse(expense.amount);

        if (dailyExpenseSummary.containsKey(date)) {
            double currentAmount = dailyExpenseSummary[date]!;
            currentAmount += amount;
            dailyExpenseSummary[date] = currentAmount;
        } else {
            dailyExpenseSummary.addAll({date: amount});
        }
    }

    return dailyExpenseSummary;
}




}