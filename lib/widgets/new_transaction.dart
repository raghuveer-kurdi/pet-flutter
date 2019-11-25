import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final expenseTitleCont = TextEditingController();

  final expenseAmountCont = TextEditingController();

  void submitted() {
    final enteredExpTitle = expenseTitleCont.text;
    final enteredExpAmount = double.parse(expenseAmountCont.text);
    if (enteredExpTitle.isEmpty || enteredExpAmount < 0) return;

    widget.addTx(enteredExpTitle, enteredExpAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
              onSubmitted: (_) {
                submitted();
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: expenseAmountCont,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                submitted();
              },
            ),
            FlatButton(
              child: Text(
                'Add Expense',
              ),
              onPressed: submitted,
            )
          ],
        ),
      ),
    );
  }
}
