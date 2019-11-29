import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final expenseTitleCont = TextEditingController();
  final expenseAmountCont = TextEditingController();
  DateTime _txDate;

  void submitted() {
    final enteredExpTitle = expenseTitleCont.text;
    final enteredExpAmount = double.parse(expenseAmountCont.text);
    if (enteredExpTitle.isEmpty || enteredExpAmount < 0 || _txDate == null)
      return;

    widget.addTx(enteredExpTitle, enteredExpAmount, _txDate);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: constraints.maxHeight * 0.05,
              left: constraints.maxHeight * 0.05,
              right: constraints.maxHeight * 0.05,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
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
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          (_txDate == null)
                              ? 'No date is chosen'
                              : DateFormat.yMd().format(_txDate),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Choose Date'),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            lastDate: DateTime.now(),
                            firstDate: DateTime(2019),
                          ).then((DateTime chosenDate) {
                            setState(() {
                              _txDate = chosenDate;
                            });
                          });
                        },
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: FittedBox(
                    child: Text(
                      'Add Expense',
                    ),
                  ),
                  onPressed: submitted,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
