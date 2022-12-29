import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalAmt;
  final double totalPercentage;
  const ChartBar(this.label, this.totalAmt, this.totalPercentage, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(
        children: <Widget>[
          Container(
              height: constrains.maxHeight * .15,
              child:
                  FittedBox(child: Text('\$${totalAmt.toStringAsFixed(0)}'))),
          SizedBox(
            height: constrains.maxHeight * .05,
          ),
          Container(
            height: constrains.maxHeight * .6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: totalPercentage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * .05,
          ),
          Container(height: constrains.maxHeight * .15, child: FittedBox(child: Text(label)))
        ],
      );
    });
  }
}
