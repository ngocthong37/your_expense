import 'package:expanse_plane/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionList(this.transactions, this.deleteTx, {Key? key})
      : super(key: key);
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: ((ctx, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight*0.3,
                ),
                const Center(child: Text('There is no transation yet')),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    child: Image.asset(
                  "assets/images/zzz.png",
                  fit: BoxFit.contain,
                ))
              ],
            );
          }))
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: FittedBox(
                            child: Text("\$${transactions[index].amount}")),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    trailing: MediaQuery.of(context).size.width > 460 ?
                      FlatButton.icon(onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Warning'),
                            content: const Text(
                                'Do you want delete this transaction?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => {
                                  deleteTx(transactions[index].id),
                                  Navigator.pop(context, 'Cancel'),
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete), 
                      label: const Text("Delete"),
                      textColor: Theme.of(context).errorColor ,)

                     : IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Warning'),
                            content: const Text(
                                'Do you want delete this transaction?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => {
                                  deleteTx(transactions[index].id),
                                  Navigator.pop(context, 'Cancel'),
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
