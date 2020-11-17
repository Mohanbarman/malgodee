import 'package:ShoppingApp/widgets/input_custom_decoration.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/styles.dart';

class TitleDescriptionForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String name;

  TitleDescriptionForm(
      {this.name, this.titleController, this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customTextField(
          title: name + ' title',
          controller: titleController,
        ),
        SizedBox(height: ScreenPadding * 2),
        customTextField(
          title: name + ' description',
          lineHeight: 5,
          controller: descriptionController,
        ),
      ],
    );
  }

  Widget customTextField(
      {String title, int lineHeight, TextEditingController controller}) {
    return Column(
      children: [
        Row(children: [Text(title, style: ProductInfoTitle)]),
        SizedBox(height: ScreenPadding),
        inputCustomDeocration(
          TextField(
            maxLines: lineHeight ?? 1,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
