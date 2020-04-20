import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // @override
  // void initState() {
  //   
  //   super.initState();
  // }

  // @override
  // void didUpdateWidget(NewTransaction oldWidget) {
  //  
  //   super.didUpdateWidget(oldWidget);
  // }

  // @override
  // void dispose() {
  //  
  //   super.dispose();
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop(); //closes modal bottom sheet
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  //onChanged: (val) => titleInput = val,
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  //onChanged: (val) => amountInput = val,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                  height: 100,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No date chosen'
                              : DateFormat.yMMMEd()
                                  .format(_selectedDate)
                                  .toString(),
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'Choose date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _presentDatePicker,
                        textColor: Theme.of(context).primaryColorDark,
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                    child: Text('Add Transaction'),
                    onPressed: _submitData,
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor),
              ],
            ),
          )),
    );
  }
}
