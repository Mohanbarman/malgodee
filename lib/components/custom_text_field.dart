import 'package:ShoppingApp/components/input_custom_decoration.dart';
import 'package:ShoppingApp/components/shimmer_placeholders.dart';
import 'package:ShoppingApp/models/phone_number.dart';
import 'package:ShoppingApp/services/firebase_api.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final int maxLength;
  final BoxShadow shadow;
  final textBloc;
  final Stream collectionStream;
  final String title;
  final String collectionName;

  TextEditingController _textEditingController = TextEditingController();

  CustomTextField({
    this.keyboardType,
    this.maxLength,
    this.shadow,
    this.textBloc,
    this.title,
    this.collectionStream,
    this.collectionName,
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
              return StreamBuilder(
                stream: collectionStream,
                builder: (context, collectionSnapshot) {
                  if (!collectionSnapshot.hasData) return TextInputShimmer();

                  String _collectionSnapshotNumber =
                      collectionSnapshot.data.docs[0]['phone_number'];
                  String _collectionSnapshotId =
                      collectionSnapshot.data.docs[0].id;

                  if (_textEditingController.value.text.length < 1) {
                    _textEditingController.value = TextEditingValue(
                      text: _collectionSnapshotNumber,
                    );
                    textBloc.updateText(_collectionSnapshotNumber);
                  }

                  return Column(
                    children: [
                      inputCustomDeocration(
                        TextFormField(
                          controller: _textEditingController,
                          keyboardType: keyboardType,
                          maxLength: maxLength,
                          onChanged: this.textBloc.updateText,
                          decoration: InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(width: ScreenPadding),
                      snapshot.hasError == true
                          ? errorTextContainer(snapshot.error)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text('Cancel'),
                                ),
                                SizedBox(width: ScreenPadding),
                                RaisedButton(
                                  onPressed: () {
                                    FirebaseStorageApi.updateDocument(
                                      model: PhoneNumberModel(
                                        id: _collectionSnapshotId,
                                        phone_number:
                                            _textEditingController.value.text,
                                      ),
                                      collection: collectionName,
                                    );
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            )
                    ],
                  );
                },
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
