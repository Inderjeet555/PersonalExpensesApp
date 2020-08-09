import 'package:flutter/material.dart';
import './newTransaction.dart';
import './transaction_List.dart';
import '../models/transactions.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transactions> _tranasactions = [
    Transactions(id: 't1', title: 'shoes', amount: 5.29, date: DateTime.now()),
    Transactions(
        id: 't1', title: 't-shirts', amount: 5.29, date: DateTime.now())
  ];

  void _addNewTransaction(String title, double amount) {
    final newTxt = Transactions(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());

    setState(() {
      _tranasactions.add(newTxt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_tranasactions),
      ],
    );
  }
}
