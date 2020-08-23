import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {    
    return Container(
        height: 450,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints){
                return Column(
                children: [
                  Text(
                    'No transactions Yet',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            } )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  // print(index);
                  return Card(
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text('\$${transactions[index].amount}')),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date)),
                      trailing: MediaQuery.of(context).size.width > 460 ?
                       FlatButton.icon(
                         onPressed: () =>
                         deleteTransaction(transactions[index].id),
                        icon: Icon(Icons.delete), label: Text('Delete'), textColor: Theme.of(context).errorColor) :
                       IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              deleteTransaction(transactions[index].id)),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
