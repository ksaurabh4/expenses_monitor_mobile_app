import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInputController = TextEditingController();
  final amountInputController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  onSubmitData() {
    final title = titleInputController.text;
    final amount = double.parse(amountInputController.text);
    final date = _selectedDate;
    if (title == "" || amount <= 0) {
      return;
    }
    widget.addTx(title, amount,date);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2019), lastDate: DateTime.now()).then((pickedDate){
      if(pickedDate == null){
  return;
      }
      _selectedDate = pickedDate;
      setState(() {
        _selectedDate;
      });
    });
}

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top:10,right: 10,left: 10,bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: titleInputController,
                  onSubmitted: (_) => onSubmitData(),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: amountInputController,
                  onSubmitted: (_) => onSubmitData(),
                  keyboardType: TextInputType.number,
                ),
                Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Selected Date'),
                      TextButton(
                          onPressed: _presentDatePicker,
                          child: Text(
                            DateFormat.yMd().format(_selectedDate),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white),
                    onPressed: onSubmitData,
                    child: const Text('Add Transaction'))
              ],
            ),
          ),
        ));
  }
}
