import 'package:flutter/material.dart';
import 'package:madmax/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    // height: very important **u can set it to 350
    //THIS IS THE SOLUTION TO VERY LONG list
    //listview.builder for scrollable list

    //if tx is empty column else ListView w rest of the code
    return Container(
        height: 350,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    'No transactions added',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 10,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      leading: FittedBox(
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 34,
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: FittedBox(
                              child: Text(
                                '¢:${transactions[index].amount.toStringAsFixed(1)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).accentColor,
                        onPressed: () =>
                            deleteTransaction(transactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }

  factory TransactionList.fromJson(Map<String, dynamic> parsedJson) {
    return new TransactionList(
      transactions: parsedJson['transactions'] ?? "",
      deleteTransaction: parsedJson['deleteTransaction'] ?? "",
    );
  }
}
