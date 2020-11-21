import 'package:ShoppingApp/widgets/crud_form/utils/multiselect_values.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

// ignore: must_be_immutable
class CrudMultiselectField extends StatelessWidget {
  final List data;
  final String title;
  final MultiSelectValuesStream multiSelectValuesStream;
  final String validationMsg;
  bool validate;

  CrudMultiselectField({
    this.data,
    this.title,
    this.multiSelectValuesStream,
    this.validationMsg,
    this.validate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MultiSelectFormField(
        dataSource: data,
        title: Text(title),
        textField: 'display',
        valueField: 'value',
        autovalidate: true,
        // ignore: missing_return
        validator: (value) {
          if (((value == null ? 0 : value.length) < 1) && validate)
            return validationMsg;
        },
        onSaved: (newValue) {
          multiSelectValuesStream.add(newValue);
        },
      ),
    );
  }
}
