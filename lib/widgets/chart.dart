import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart(this.recentTransactions, {super.key});

  List<Map<String, Object>> get groupTransactionList {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalExp {
    return groupTransactionList.fold(
        0.0, (sum, item) => sum + (item['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTransactionList
                .map((val) => ChartBar(
                    (val['day'] as String),
                    (val['amount'] as double),
                    totalExp == 0.0
                        ? 0.0
                        : (val['amount'] as double) / totalExp))
                .toList(),
          ),
        ));
  }
}
