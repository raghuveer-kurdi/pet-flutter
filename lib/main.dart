import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/transaction.dart';

void main() {
  runApp(PersonalExpense());
}

class PersonalExpense extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 'tx1',
      title: 'New Shoes',
      amount: 100,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'tx2',
      title: 'Groceries',
      amount: 16.43,
      date: DateTime.now(),
    )
  ];

  final TextEditingController expenseTitleCont = TextEditingController();
  final TextEditingController expenseAmountCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personal Expense Tracker'),
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                color: Colors.red,
                child: Text('Expense Chart'),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Expense Title'),
                        controller: expenseTitleCont,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Amount'),
                        controller: expenseAmountCont,
                      ),
                      FlatButton(
                        child: Text(
                          'Add Expense',
                          style: TextStyle(color: Colors.pinkAccent),
                        ),
                        onPressed: () {
                          print(expenseTitleCont.value.toString());
                          print(expenseAmountCont.value.toString());
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    ...transactions.map((tx) {
                      return Card(
                        elevation: 10,
                        child: Row(
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Colors.pinkAccent),
                                ),
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.all(10),
                                child: Text(
                                  '\$${tx.amount}',
                                  style: TextStyle(
                                      color: Colors.pinkAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  tx.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  DateFormat('yMMMd').format(tx.date),
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }).toList()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
