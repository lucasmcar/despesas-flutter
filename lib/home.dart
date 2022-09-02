
import 'dart:math';
import 'package:despesas_pessoasis/components/chart.dart';
import 'package:despesas_pessoasis/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<Transaction> transactions = [
  ];

  List<Transaction> get _recentTransaction{
    return transactions.where((tr){
        return tr.date!.isAfter(
            DateTime.now().subtract(Duration(days: 7)
            )
        );
    }).toList();
  }

  void _addTrasanction(String title, double value, DateTime dateTransaction){
    var newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: dateTransaction
    );

    setState(() {
      transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id){
    setState(() {
      transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  _openTransactionFormModal
      (BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (_){
          return TransactionForm(_addTrasanction);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Despesas pessoais"),
          actions: [
            IconButton(
              onPressed: () => _openTransactionFormModal(context),
              icon: Icon(Icons.add)
            ),
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Chart(_recentTransaction)
              ),
            TransactionList(transactions, _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
