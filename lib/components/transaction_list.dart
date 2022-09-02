import 'package:despesas_pessoasis/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  void Function(String) onRemove;

  List<Transaction> _transactions;
  TransactionList(this._transactions,this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
        child: ListView.builder(
          itemCount: _transactions.length,
          itemBuilder: (context, index){
            var tr = _transactions[index];
            return Card(
              elevation: 6,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5
              ),
              child: ListTile(
                trailing: IconButton(
                    onPressed: () => onRemove(tr.id!) ,
                    icon: Icon(Icons.delete)
                ),
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: EdgeInsets.all(8) ,
                    child: FittedBox(
                      child: Text(
                        'R\$ ${tr.value?.toStringAsFixed(2)}'
                      ),
                    ),
                  ),
                ),
                title: Text(
                    tr.title!,
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400
                  ),
                ),
                subtitle: Text(
                  DateFormat('dd/MM/y').format(tr.date!),
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
