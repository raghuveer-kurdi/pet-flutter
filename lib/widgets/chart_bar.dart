import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double spendingInPerc;
  ChartBar(this.label, this.spending, this.spendingInPerc);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.02),
          child: Column(
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                  child: Text(
                    '\$${spending.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.02,
              ),
              Container(
                height: constraints.maxHeight * 0.6,
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
              SizedBox(
                height: constraints.maxHeight * 0.02,
              ),
              Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
