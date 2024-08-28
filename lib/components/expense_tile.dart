import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

   ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children:[
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: const Color.fromARGB(255, 206, 24, 11),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
  
   child: ListTile(
  title: Text(
    name,
    style: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), 
      fontWeight: FontWeight.bold,

      ),
    ),
  ),
  subtitle: Text(
    '${dateTime.month} / ${dateTime.day} / ${dateTime.year}',
    style: const TextStyle(
      color: Colors.grey, // Change this to your desired color
    ),
  ),
  trailing: Text(
    '\$$amount',
    style: const TextStyle(
      color: Color.fromARGB(255, 255, 255, 255), // Optional: Set the color for the trailing text
    ),
  ),
   ),




    ); 
  }
}
