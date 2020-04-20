import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constriants) {
            return Column(children: <Widget>[
              Text('No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6),
              SizedBox(
                height: 20,
              ),
              Container(
                height: constriants.maxHeight * 0.6,
                child: Image.asset('assets/images/image_waiting.png',
                    fit: BoxFit.cover),
              ),
            ]);
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 10,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 40,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: FittedBox(
                          child: Text('\$${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(transactions[index].title,
                      style: Theme.of(context).textTheme.headline6),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].id),
                        ),
                ),
              );
            });
  }
}
