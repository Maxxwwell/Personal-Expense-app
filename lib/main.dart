import 'package:flutter/material.dart';
import 'package:madmax/widgets/new_transactions.dart';
import 'package:madmax/widgets/transaction_list.dart';
import 'package:madmax/models/transaction.dart';
import 'package:madmax/widgets/chart.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        theme: ThemeData(
            primaryColor: Colors.blueGrey[300],
            accentColor: Colors.pink[50],
            fontFamily: 'OpenSans'),
        home: MyHomePage(),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  
  
  final List<Transaction> _userTransactions = [
    //list.. data tyoe.. variable.. listHolder[]
    // Transaction(
    //   id: 't1',
    //   title: 'New sneaker',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New watch',
    //   amount: 79.99,
    //   date: DateTime.now(),
    // ),
  ];
  

  @override
  void initState() {
    
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  dispose() {
    
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //return txdate isAfter date now - 7 days
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList(); //expects a list
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  //private function
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(addTx: _addNewTransaction));
      },
    );
  }

  void _deleteTransactions(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Personal Expenses',
            style: TextStyle(
              fontSize: 24,
              //fontWeight: FontWeight.bold
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          //to enable scrolling
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(_recentTransactions),
              SizedBox(
                height: 10,
              ),
              TransactionList(transactions: _userTransactions, deleteTransaction: _deleteTransactions),
            ],
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }

}
  