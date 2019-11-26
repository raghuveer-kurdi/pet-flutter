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

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ...groupedTransactions.map((gData) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  gData['day'],
                  gData['amount'],
                  (totalSpending == 0)
                      ? 0.0
                      : (gData['amount'] as double) / totalSpending),
            );
          }).toList(),
        ],
      ),
    );
  }
}
