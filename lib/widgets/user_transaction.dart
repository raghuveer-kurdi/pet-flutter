import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './list_of_transaction.dart';
import './new_transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  void _addTransaction(String title, double amount) {
    setState(() {
      _transactions.add(Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now(),
      ));
    });
  }

  final List<Transaction> _transactions = [
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          NewTransaction(_addTransaction),
          ListOfTransactions(_transactions)
        ],
      ),
    );
  }
}
