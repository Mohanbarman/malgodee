import 'package:ShoppingApp/widgets/input_custom_decoration.dart';
import 'package:ShoppingApp/models/phone_number.dart';
import 'package:ShoppingApp/services/firestore_api.dart';
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

  int i = 0;

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
                  if (!collectionSnapshot.hasData) return SizedBox();

                  String _collectionSnapshotNumber =
                      collectionSnapshot.data.docs.first['phone_number'];
                  String _collectionSnapshotId =
                      collectionSnapshot.data.docs.first.id;

                  if (i == 0) {
                    _textEditingController.value = TextEditingValue(
                      text: _collectionSnapshotNumber,
                    );

                    i++;
                  }

                  // textBloc.updateText(_collectionSnapshotNumber);

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
                                  onPressed: () {
                                    _textEditingController.value =
                                        TextEditingValue(
                                      text: _collectionSnapshotNumber,
                                    );
                                  },
                                  child: Text('Cancel'),
                                ),
                                SizedBox(width: ScreenPadding),
                                RaisedButton(
                                  onPressed: () {
                                    // print(_collectionSnapshotId);
                                    FirebaseStorageApi.updateDocument(
                                      model: PhoneNumberModel(
                                        id: _collectionSnapshotId,
                                        phone_number:
                                            _textEditingController.value.text,
                                      ).toJson(),
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
