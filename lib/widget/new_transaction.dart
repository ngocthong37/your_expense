// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';


class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount < 0) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }


  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now())
      .then((pickDate) {
      if (pickDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(

          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10
          ),
          child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            controller: _titleController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Amount"),
            controller: _amountController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(child: Text(_selectedDate == null ? "No Date Chosen" :"Picked Date: " + DateFormat().add_yMMMEd().format(_selectedDate))),
              Platform.isIOS ? CupertinoButton(
                onPressed: () {
                    _presentDatePicker();
                },
                child: const Text(
                    "Choose date",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  )) : FlatButton(
                  onPressed: () {
                    _presentDatePicker();
                  },
                  child: const Text(
                    "Choose date",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          RaisedButton(
            color: Colors.green,
            onPressed: () {
              submitData();
            },
            child: const Text(
              "Add Transaction",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      )
      )
      ),
    );
  }
}
