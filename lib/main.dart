import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/list_of_transaction.dart';
import './widgets/new_transaction.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
            button: TextStyle(
              color: Colors.white,
            )),
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
  bool _isShowChartSwitch = false;
  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addTransaction);
        });
  }

  void _deleteTransaction(String txId) {
    if (txId == null) return;
    setState(() {
      _transactions.removeWhere((tx) => tx.id == txId);
    });
  }

  void _addTransaction(String title, double amount, DateTime date) {
    if (title.isEmpty || amount < 0) {
      return;
    }

    final transaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
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
    // Transaction(
    //   id: 'tx1',
    //   title: 'New Shoes',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'tx2',
    //   title: 'Groceries',
    //   amount: 16.43,
    //   date: DateTime.now(),
    // )
  ];
  @override
  Widget build(BuildContext context) {
    final mediaQueryObj = MediaQuery.of(context);
    final isLandScape = mediaQueryObj.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expense'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startNewTransaction(context);
          },
        )
      ],
    );

    final txWidgetList = Container(
        height: (mediaQueryObj.size.height -
                appBar.preferredSize.height -
                mediaQueryObj.padding.top) *
            0.7,
        child: ListOfTransactions(_transactions, _deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Transactions'),
                  Switch.adaptive(
                    value: _isShowChartSwitch,
                    onChanged: (val) {
                      setState(() {
                        _isShowChartSwitch = val;
                      });
                    },
                  ),
                  Text('Chart')
                ],
              ),
            if ((_isShowChartSwitch && isLandScape) || !isLandScape)
              Container(
                  height: (mediaQueryObj.size.height -
                          appBar.preferredSize.height -
                          mediaQueryObj.padding.top) *
                      ((!isLandScape) ? 0.3 : 0.7),
                  child: Chart(_recentTransactions)),
            if (!_isShowChartSwitch && isLandScape || !isLandScape)
              txWidgetList,
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
