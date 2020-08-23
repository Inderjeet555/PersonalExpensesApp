import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:personalExpApp/widgets/newTransaction.dart';
import './widgets/transaction_List.dart';
import './models/transactions.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transactions> _tranasactions = [
    // Transactions(id: 't1', title: 'shoes', amount: 5.29, date: DateTime.now()),
    // Transactions(
    //     id: 't1', title: 't-shirts', amount: 5.29, date: DateTime.now())
  ];

  List<Transactions> get _recentTransactions {
    return _tranasactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTxt = Transactions(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);

    setState(() {
      _tranasactions.add(newTxt);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _tranasactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startNewTransaction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final _isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;    

    final appBar = AppBar(
      title: Text('Track Expenses'),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add), onPressed: _startNewTransaction),
      ],
    );

    final _listViewWidget = Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(_tranasactions, _deleteTransaction));

    return Scaffold(
      //resizeToAvoidBottomPadding: false, //Remove at the end
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandScape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch.adaptive(
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                      
                    })
              ],
            ),
            if(!_isLandScape)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
            if (!_isLandScape) _listViewWidget,

            if(_isLandScape)
            _showChart == true ?
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: Chart(_recentTransactions)) :
            _listViewWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _startNewTransaction,
        child: Icon(Icons.add),
      ),
    );
  }
}
