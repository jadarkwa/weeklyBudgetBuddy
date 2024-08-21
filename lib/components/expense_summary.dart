import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weeklyfinancetracker/bar%20graph/bar_graph.dart';
import 'package:weeklyfinancetracker/data/expense_data.dart';
import 'package:weeklyfinancetracker/datetime/date_time_helper.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  // calculate max amount in bar graph
double calculateMax(
  ExpenseData value,
  String sunday,
  String monday,
  String tuesday,
  String wednesday,
  String thursday,
  String friday,
  String saturday,
){

double? max = 100;

List<double> values = [
 value.calculateDailyExpenseSummary()[sunday] ?? 0,
 value.calculateDailyExpenseSummary()[monday] ?? 0,
 value.calculateDailyExpenseSummary()[tuesday] ?? 0,
 value.calculateDailyExpenseSummary()[wednesday] ?? 0,
 value.calculateDailyExpenseSummary()[thursday] ?? 0,
 value.calculateDailyExpenseSummary()[friday] ?? 0,
 value.calculateDailyExpenseSummary()[saturday] ?? 0,
];

// sort from smallest to largest
values.sort();

max = values.last * 1.1;

return max == 0 ? 100: max;
}

String calculateWeekTotal(
  ExpenseData value,
  String sunday,
  String monday,
  String tuesday,
  String wednesday,
  String thursday,
  String friday,
  String saturday,
){

  List<double> values = [
    value.calculateDailyExpenseSummary()[sunday] ?? 0,
    value.calculateDailyExpenseSummary()[monday] ?? 0,
    value.calculateDailyExpenseSummary()[tuesday] ?? 0,
    value.calculateDailyExpenseSummary()[wednesday] ?? 0,
    value.calculateDailyExpenseSummary()[thursday] ?? 0,
    value.calculateDailyExpenseSummary()[friday] ?? 0,
    value.calculateDailyExpenseSummary()[saturday] ?? 0,

  ];


double total = 0;

 for (int i = 0; i < values.length; i++){
  total += values[i];
}

return total.toStringAsFixed(2);

}

@override
Widget build(BuildContext context) {
  // Get yyyymmdd for each day of this week
  String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
  String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
  String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
  String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
  String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
  String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
  String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
    builder: (context, value, child) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Weekly Budget
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0), // Reduced vertical padding
          child: Row(
            children: [
              const Text(
                "WEEKLY BUDGET",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(width: 8.0), // Small space between text and value
              Text(
                "\$${value.weeklyBudget.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),

        // Week Total
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0), // Reduced vertical padding
          child: Row(
            children: [
              const Text(
                "WEEK TOTAL",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(width: 8.0), // Small space between text and value
              Text(
                "\$${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}",
                style: const TextStyle(
                  fontSize: 20.0, // Set the desired font size
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 200,
          child: MyBarGraph(
            maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
            sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
            monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
            tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
            wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
            thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
            friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
            satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
          ),
        ),

          // Expenditures Heading
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0), // Add padding around heading
            child: Text(
              "EXPENDITURES",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0, // Larger font size for heading
              ),
            ),
          ),


      ],
    ),
  );
}


}
