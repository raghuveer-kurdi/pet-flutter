import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double spendingInPerc;
  ChartBar(this.label, this.spending, this.spendingInPerc);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          FittedBox(
            child: Text(
              '\$${spending.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
            width: 20,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingInPerc,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.title,
          )
        ],
      ),
    );
  }
}
