import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weeklyfinancetracker/components/expense_summary.dart';
import 'package:weeklyfinancetracker/components/expense_tile.dart';
import 'package:weeklyfinancetracker/data/expense_data.dart';
import 'package:weeklyfinancetracker/models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseDollarController = TextEditingController();
  final newExpenseCentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }



 void addNewExpense() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Add new expense'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // expense name
          TextField(
            controller: newExpenseNameController,
            decoration: const InputDecoration(
              hintText: "Expense Name",
            ),

          ),

      Row(
        children: [
        //dollars
        Expanded(
        child: TextField(
          controller:newExpenseDollarController,
          keyboardType: TextInputType.number,
           decoration: const InputDecoration(
            hintText: "\$",
            ),
          ),
        ),

        

        //cents
        Expanded(
        child: TextField(
          controller:newExpenseCentsController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
           hintText: "¢",
            ),
          ),
        ),


          ],),
       ],
      ),

        
      actions: [
        // save button
        MaterialButton(
          onPressed: save,
          child: const Text('Save'),
        ),

         MaterialButton(
          onPressed: cancel,
          child: const Text('Cancel'),
        ),
        // cancel button
      ],
    ),
  );
}

void addWeeklyBudget() {
  showDialog(
    context: context,
    builder: (context) {
      final budgetController = TextEditingController(); // Controller for the budget input
      return AlertDialog(
        title: const Text('Set Weekly Budget'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Enter your weekly budget",
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              if (budgetController.text.isNotEmpty) {
                double budget = double.parse(budgetController.text);
                Provider.of<ExpenseData>(context, listen: false).setWeeklyBudget(budget);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}







void deleteExpense(ExpenseItem expense){
  Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
}


void save() {
//added

if(newExpenseNameController.text.isNotEmpty && (newExpenseDollarController.text.isNotEmpty || newExpenseCentsController.text.isNotEmpty)){

  String amount = 
  '${newExpenseDollarController.text}.${newExpenseCentsController.text}';

  // create expense item
  ExpenseItem newExpense = ExpenseItem(
    name: newExpenseNameController.text,
    amount: amount,
    dateTime: DateTime.now(),
  ); // ExpenseItem

  Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    }

  Navigator.pop(context);
  clear();
}



void cancel() {
  Navigator.pop(context);
  clear();
}

 void clear() {
  newExpenseNameController.clear();
  newExpenseDollarController.clear();
  newExpenseCentsController.clear();
}



@override
Widget build(BuildContext context) {
  return Consumer<ExpenseData>(
    builder: (context, value, child) => Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 192, 168),
      body: ListView(
        children: [
          ExpenseSummary(startOfWeek: value.startOfWeekDate()),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: value.getAllExpenseList().length,
            itemBuilder: (context, index) => ExpenseTile(
              name: value.getAllExpenseList()[index].name,
              amount: value.getAllExpenseList()[index].amount,
              dateTime: value.getAllExpenseList()[index].dateTime,
              deleteTapped: (p0) => deleteExpense(value.getAllExpenseList()[index]),
            ),
          ),
        ],
      ),
floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16.0, // Adjust as needed
            left: 40.0, // Adjust as needed
            child: FloatingActionButton(
              onPressed: addWeeklyBudget,
              backgroundColor: Color.fromARGB(255, 175, 114, 78),
              child: const Icon(Icons.attach_money),
            ),
          ),
          Positioned(
            bottom: 16.0, // Same as above for alignment
            right: 16.0, // Adjust as needed
            child: FloatingActionButton(
              onPressed: addNewExpense,
              backgroundColor: Color.fromARGB(255, 175, 114, 78),
              child: const Icon(Icons.add_circle_outline),
            ),
          ),
        ],
      ),
    ),
  );
  }
}