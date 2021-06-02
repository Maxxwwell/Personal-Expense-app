import 'package:flutter/foundation.dart';

class Transaction {
//properties or variables  
  String id;
  String title;
  double amount;
  DateTime date;

//constructor
  Transaction({
    @required this.id, 
    @required this.title, 
    @required this.amount, 
    @required this.date,
    });

//faction class to convert object from json
  factory Transaction.fromJson(Map<String,dynamic> parsedJson){
    return new Transaction(
      id: parsedJson['id'] ?? "", 
      title: parsedJson['title'] ?? "", 
      amount: parsedJson['amount'] ?? "", 
      date: parsedJson['date'] ?? ""
      );
  }

}
