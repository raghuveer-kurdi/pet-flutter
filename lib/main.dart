import 'package:flutter/material.dart';
import './widgets/user_transaction.dart';

void main() {
  runApp(PersonalExpense());
}

class PersonalExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Personal Expense Tracker'),
            actions: <Widget>[
              IconButton( icon: Icons.add,)
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  color: Colors.red,
                  child: Text('Expense Chart'),
                ),
                UserTransaction(),
              ],
            ),
          )),
    );
  }
}
