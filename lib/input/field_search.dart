
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldSearch extends StatefulWidget {

  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final Function onTap;
  final int lines;
  final BuildContext context;

  const FieldSearch({
    this.validator,
    this.controller,
    this.onTap,
    this.lines = 1,
    this.context
  });

  @override
  _FieldSearchState createState() => _FieldSearchState();
}

class _FieldSearchState extends State<FieldSearch> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: TextInputType.text,
      autocorrect: true,
      textCapitalization: TextCapitalization.sentences,
      onTap: widget.onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Search',
        hintMaxLines: widget.lines,
        contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0,),
        hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.0, color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),),
        prefixIcon: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
          padding: EdgeInsets.only(right: 15.0, left: 20.0),
        ),
        suffixIcon: widget.controller.text.length > 0 ? IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) => widget.controller.clear());
          },
          padding: EdgeInsets.only(right: 15.0),
        ) : null,
      )
    );
  }
}
