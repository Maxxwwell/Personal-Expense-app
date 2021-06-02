import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction({this.addTx});

  @override
  _NewTransactionState createState() => _NewTransactionState();

factory NewTransaction.fromJson(Map<String,dynamic> parsedJson){
    return new NewTransaction(
      addTx: parsedJson['addTx'] ?? "",
      );
  }

}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if (amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    //convert the text to double
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; //with this it wont execute if empty

    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  //function to present datePicker
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      //to change the text to date..
      setState(() {
           _selectedDate = pickedDate;    
            });
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 83, right: 83, bottom: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                textAlign: TextAlign.center,
                onSubmitted: (_) => _submitData(),
                // onChanged: (newText) {
                //   titleInput = newText;
                // },
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                textAlign: TextAlign.center,
                // onChanged: (newText2) {
                //   amountInput = newText2;}
                controller: amountController,
                keyboardType: TextInputType.number, //4 making only numbers
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                      //if selectedDate is empty 'no date chosen' else selectedDate(In the right format)
                  Text(_selectedDate == null ?'No Date Chosen': DateFormat.yMMMd().format(_selectedDate),
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Expanded(
                        child: Text(
                          'Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: _presentDatePicker),
                ],
              ),
              RaisedButton(
                  onPressed: _submitData,
                  //onpress takes a function n submitData is a function
                 
                  textColor: Colors.black,
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  color: Theme.of(context).accentColor),
            ],
          ),
        ),
      );
    
  }
}
