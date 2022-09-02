import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _valueController = new TextEditingController();
  DateTime? _selectedDate;

  _submitForm(){
    var title = _titleController.text;
    var value = double.tryParse(_valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0){
      return;
    }
    widget.onSubmit(title, value, _selectedDate!);
  }

  _showDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now()
    ).then((pickedDate){
      setState(() {
        _selectedDate = pickedDate!;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                    labelText: 'Titulo'),
              ),
              TextField(
                  controller: _valueController,
                  onSubmitted: (_) => _submitForm(),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true
                  ),
                  decoration: InputDecoration(
                      labelText: 'Valor'
                  )
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada'
                            : DateFormat('dd/MM/y').format(_selectedDate!)
                    ),
                    ElevatedButton(

                        onPressed: _showDatePicker,
                        child: Text('Selecionar Data')
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed:(){ _submitForm(); },
                      child: Text('Nova Transação')
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
