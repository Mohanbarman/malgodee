import 'package:ShoppingApp/components/input_custom_decoration.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final int maxLength;
  final BoxShadow shadow;
  final textBloc;
  final String title;

  TextEditingController _textEditingController = TextEditingController();

  CustomTextField({
    this.keyboardType,
    this.maxLength,
    this.shadow,
    this.textBloc,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(children: [Text(this.title, style: LoginFormLabelStyle)]),
          SizedBox(height: ScreenPadding / 2),
          StreamBuilder(
            stream: this.textBloc.textStream,
            builder: (context, snapshot) {
              return Column(
                children: [
                  inputCustomDeocration(
                    TextFormField(
                      keyboardType: keyboardType,
                      controller: _textEditingController,
                      maxLength: maxLength,
                      onChanged: this.textBloc.updateText,
                      decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  snapshot.hasError == true
                      ? errorTextContainer(snapshot.error)
                      : SizedBox(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget errorTextContainer(String errorText) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(ScreenPadding / 2),
          child: Text(
            errorText,
            style: inputErrorTextStyle,
          ),
        ),
      ],
    );
  }
}
