import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSpending = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        final tx = recentTransactions[i];
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSpending += tx.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSpending,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ...groupedTransactions.map((gData) {
          return ChartBar(gData['day'], gData['amount'], 0.0);
        }).toList(),
      ],
    );
  }
}
