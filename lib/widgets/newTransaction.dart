import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactionPointer;

  NewTransaction(this.addTransactionPointer);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime _pickedDate;

  void addTransaction() {
    if (amountController.text.isEmpty) {
      return;
    }

    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount < 0 || _pickedDate == null) {
      return;
    }

    widget.addTransactionPointer(title, amount, _pickedDate);
    Navigator.of(context).pop();
  }

  void _presendDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedValue) {
      if (pickedValue == null) {
        return;
      }
      setState(() {
        _pickedDate = pickedValue;
      });
    });
  }

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
              onSubmitted: (_) => addTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addTransaction(),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                        child: Text(_pickedDate == null
                        ? 'No Date Chosen'
                        : DateFormat.yMMMd().format(_pickedDate)),
                  ),
                  FlatButton(
                    onPressed: _presendDatePicker,
                    child: Text(
                      'choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: addTransaction,
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
