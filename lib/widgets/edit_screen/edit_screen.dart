import 'package:ShoppingApp/styles.dart';
import 'local_utils/single_image_pick_bloc.dart';
import 'package:ShoppingApp/widgets/underlined_text.dart';
import 'package:flutter/material.dart';
import 'package:ShoppingApp/widgets/app_bar.dart';
import 'package:ShoppingApp/widgets/bottom_navigation_bar.dart';
import 'local_widgets/image_preview.dart';

class EditScreen extends StatelessWidget {
  String title;
  String titleOftitleField;
  String titleOfDescriptionField;
  String imageUrl;

  EditScreen({
    this.title,
    this.titleOftitleField,
    this.titleOfDescriptionField,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomNavigationBar(null),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          ScreenPadding,
          ScreenPadding,
          ScreenPadding,
          0,
        ),
        children: [
          Title(title),
          SizedBox(height: 30),
          ImagePreview(bloc: SingleImagePickBloc()),
        ],
      ),
    );
  }

  Widget Title(String title) {
    return SizedBox(
      height: 50,
      child: Center(
        child: UnderlinedText(title).noUnderline(),
      ),
    );
  }
}
