import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delTx;
  const TransactionList(this.transactions, this.delTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                'No Transactions',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            itemBuilder: (cxt, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 4),
                          child: FittedBox(
                              child: Text(
                                  '\$${transactions[index].amount.toStringAsFixed(2)}')),
                        ),
                      )),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => delTx(transactions[index].id),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            },
            itemCount: transactions.length);
  }
}
