
import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransactionPointer;

  NewTransaction(this.addTransactionPointer);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),  
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: (() {
                  addTransactionPointer(titleController.text, double.parse(amountController.text));
                  print(titleController.text);
                }),
                child: Text(
                  'Add Transaction',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
