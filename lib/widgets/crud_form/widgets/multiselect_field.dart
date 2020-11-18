import 'package:ShoppingApp/widgets/crud_form/utils/multiselect_values.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class CrudMultiselectField extends StatelessWidget {
  final List data;
  final String title;
  final MultiSelectValuesStream multiSelectValuesStream;
  final String validationMsg;

  CrudMultiselectField({
    this.data,
    this.title,
    this.multiSelectValuesStream,
    this.validationMsg,
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
        validator: (value) {
          if ((value == null ? 0 : value.length) < 1) {
            return validationMsg;
          }
        },
        onSaved: (newValue) {
          multiSelectValuesStream.add(newValue);
        },
      ),
    );
  }
}
