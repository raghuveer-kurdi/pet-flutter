import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/list_of_transaction.dart';
import './widgets/new_transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      home: PersonalExpense(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amberAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class PersonalExpense extends StatefulWidget {
  @override
  _PersonalExpenseState createState() => _PersonalExpenseState();
}

class _PersonalExpenseState extends State<PersonalExpense> {
  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addTransaction);
        });
  }

  void _addTransaction(String title, double amount) {
    if (title.isEmpty || amount < 0) {
      return;
    }

    final transaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );
    setState(() {
      _transactions.add(transaction);
    });
    Navigator.of(context).pop();
  }

  List<Transaction> get _recentTransactions {
    final lastRecent = DateTime.now().subtract(Duration(days: 7));
    return _transactions.where((tx) {
      return tx.date.isAfter(lastRecent);
    }).toList();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startNewTransaction(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            ListOfTransactions(_transactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startNewTransaction(context);
        },
      ),
    );
  }
}
