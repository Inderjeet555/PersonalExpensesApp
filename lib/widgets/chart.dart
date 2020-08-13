import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSpend = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSpend += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSpend);

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSpend};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.00, (sum, itms) {
      return sum + itms['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),      
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: 
            groupedTransactionsValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(data['day'], data['amount'], totalSpending == 0.00 ? 0.00 : (data['amount'] as double) / totalSpending));
            }).toList(),       
        ),
      ),
    );
  }
}
