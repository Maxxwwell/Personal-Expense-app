import 'dart:async';
import 'dart:convert';
import 'package:madmax/constant/constants.dart';
import 'package:madmax/models/transaction.dart';
import 'package:madmax/widgets/new_transactions.dart';
import 'package:madmax/widgets/transaction_list.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppSharedPreferences {
///////////////////////////////////////////////////////////////////////////////
//   static Future<SharedPreferences> getInstance() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs;
//   }

// ///////////////////////////////////////////////////////////////////////////////
//   static Future<void> clear() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//   }

// ///////////////////////////////////////////////////////////////////////////////
//   static Future<String> getString(String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(value);
//   }

//   static Future<void> setString(String key,String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setString(key, value);

  // }
///////////////////////////////////////////////////////////////////////////////
 static Future<Transaction> getTransaction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Transaction.fromJson(
        json.decode(prefs.getString(SharedPreferenceKeys.TRANSACTIONS_LIST)));
  }
////////////////////////////////////////////////////////////////////////////////
  static Future<void> setTransaction(Transaction transaction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String transactionJson = json.encode(transaction);
    return prefs.setString(SharedPreferenceKeys.TRANSACTIONS_LIST, transactionJson);
  }

}