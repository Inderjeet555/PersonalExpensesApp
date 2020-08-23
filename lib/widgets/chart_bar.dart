import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmount;
  final double spendPerc;

  ChartBar(this.label, this.spendAmount, this.spendPerc);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
       return Column(
      children: [
        Container(
            height: constraints.maxHeight * 0.15,
            child:
                FittedBox(child: Text('\$${spendAmount.toStringAsFixed(0)}'))),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(
          height: constraints.maxHeight * 0.60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                  heightFactor: spendPerc,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(height: constraints.maxHeight * 0.15, child: FittedBox(child: Text(label))),
      ],
    );
    });
    
  }
}
