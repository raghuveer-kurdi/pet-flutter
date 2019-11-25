import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double spendingInPerc;
  ChartBar(this.label, this.spending, this.spendingInPerc);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 50,
      child: Column(
        children: <Widget>[
          Text(
            '\$$spending',
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(
            height: 20,
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
