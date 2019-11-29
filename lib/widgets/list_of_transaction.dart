import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transaction.dart';

class ListOfTransactions extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  ListOfTransactions(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Container(
          child: (transactions.isEmpty)
              ? Column(
                  children: <Widget>[
                    Container(
                      height: constraints.maxHeight * 0.4,
                      child: FittedBox(
                        child: Text(
                          'No transactions added yet!',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                    ),
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ))
                  ],
                )
              : ListView.builder(
                  itemBuilder: (bCtx, index) {
                    var tx = transactions[index];
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 5,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text(
                                '\$${tx.amount}',
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          tx.title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                        trailing: MediaQuery.of(context).size.width > 400
                            ? FlatButton.icon(
                                icon: Icon(Icons.delete),
                                label: Text('Delete'),
                                textColor: Theme.of(context).errorColor,
                                onPressed: () {
                                  deleteTx(tx.id);
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.delete),
                                color: Theme.of(context).errorColor,
                                onPressed: () {
                                  deleteTx(tx.id);
                                },
                              ),
                      ),
                    );
                  },
                  itemCount: transactions.length,
                ),
        );
      },
    );
  }
}
