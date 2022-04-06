import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
   ChartBar({
       required this.label,
       required this.spendingAmount,
       required this.spendingPctTotal});
  final String label;
  final double spendingAmount;

  final double spendingPctTotal;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,  constraints) {
      return Column(
      children: [
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(child: Text("\$" + spendingAmount.toStringAsFixed(0)))
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(
          height: constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight * 0.05,
        ),
        Container(
          height: constraints.maxHeight * 0.15,
          child: FittedBox(child: Text(label))),
      ],
    );
    }); 
  }
}
