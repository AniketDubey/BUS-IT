// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'StartPage.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:minoragain/models/DUMMYDATA.dart';
import 'package:minoragain/models/Station.dart';
import 'package:provider/provider.dart';
import 'package:minoragain/models/Provider.dart';

class HomePage extends StatelessWidget {
  //const HomePage({ Key? key }) : super(key: key);

  String sta;
  Map<String, String> details;
  HomePage(this.sta, this.details);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  //Provider.of<BList>(context, listen: false).screenChange();

  @override
  Widget build(BuildContext context) {
    Provider.of<BList>(context, listen: false).screenChange();
    return Form(
      key: _formKey,
      child: TypeAheadFormField(
        suggestionsCallback: (pattern) {
          //print(vec);
          sList.sort((a, b) => a.sName.compareTo(b.sName));
          return sList.where(
            (items) => items.sName.toLowerCase().startsWith(
                  pattern.toLowerCase(),
                ),
          );
        },
        itemBuilder: (_, Station suggestion) {
          return ListTile(
            title: Text(
              suggestion.sName.toString(),
            ),
          );
        },
        getImmediateSuggestions: true,
        hideSuggestionsOnKeyboardHide: false,
        hideOnEmpty: false,
        noItemsFoundBuilder: (context) {
          return const Padding(
            padding: EdgeInsets.all(8),
            child: Text("No Items Found"),
          );
        },
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: sta,
            labelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.black,
              ),
            ),
          ),
          controller: this._textEditingController,
        ),
        onSuggestionSelected: (Station val) {
          this._textEditingController.text = val.sName.toString();
          if (sta == "Source Station")
            details["Source"] = val.sName.toString();
          else
            details["Destination"] = val.sName.toString();
        },
      ),
    );
  }
}
