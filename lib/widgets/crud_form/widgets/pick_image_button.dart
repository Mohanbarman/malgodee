import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ShoppingApp/styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageButton extends StatelessWidget {
  final bloc;
  PickImageButton({@required this.bloc});

  void addImage() async {
    final picker = ImagePicker();
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    bloc.add(pickedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Container(
          width: 160,
          child: RaisedButton(
            color: SecondaryColor,
            elevation: 5,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            onPressed: addImage,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(FeatherIcons.upload, color: Colors.white),
                Text('Add image', style: UploadButtonTextStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
