import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transaction.dart';

class ListOfTransactions extends StatelessWidget {
  final List<Transaction> transactions;
  ListOfTransactions(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (bCtx, index) {
          var tx = transactions[index];
          return Card(
            elevation: 10,
            child: Row(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.pinkAccent),
                    ),
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      '\$${tx.amount.toStringAsFixed(2)}',
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
        },
        itemCount: transactions.length,
      ),
    );
  }
}
